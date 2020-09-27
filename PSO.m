function out = PSO(problem,params)
    costFunction = problem.costFunction;
    nVar = problem.nVar;%number of unknown (Decision Variable)
    VarSize = [ 1 nVar];
    VarMin=problem.VarMin;%lower bound
    VarMax=problem.VarMax;%upper bound
    desiredFilter=problem.desiredFilter;%transfer function of filter
    [desiredFilter_h, desiredFilter_w] = freqz(desiredFilter, 1, 'whole', 1000);%frequency response
    order=problem.order;
    noOfCoeff=order+1;
    %% Parameters of PSO
    MaxIt=params.MaxIt;%maximum number of iteration
    nPop=params.nPop;% population size
    w=params.w;%inertial coefficient
    wdamp=params.wdamp;% damping ratio of inertial coefficient
    c1=params.c1;% personal acceleration ceofficient
    c2=params.c2;
    
    % The Flag for Showing Iteration Information
    ShowIterInfo = params.ShowIterInfo;
    isfirstPrint = params.isfirstPrint;

    MaxVelocity = 0.2*(VarMax-VarMin);
    MinVelocity = -MaxVelocity;
    
    %% Starting plot of desired graph
    figure('name', 'PSO on FIR order 31');
    subplot(1,2,1);
    plot(desiredFilter_w/pi,20*log10(abs(desiredFilter_h)));

    %% Initialisation
    empty_particle.Position=[];
    empty_particle.Velocity=[];
    empty_particle.Cost=[];%cost of reaching this position
    empty_particle.Best.Position=[];%best position reached by particle till now
    empty_particle.Best.Cost=[];
    
    particle=repmat(empty_particle,nPop,1);%repeating empty_particle in npop column and 1 row
    
    GlobalBest.Cost=inf;%by default global best in infinity
    GlobalBest.Position = unifrnd(VarMin,VarMax, VarSize, noOfCoeff);

    for i=1:nPop
        particle(i).Position=unifrnd(VarMin,VarMax, VarSize, noOfCoeff);
        particle(i).Velocity=unifrnd(MinVelocity,MaxVelocity, VarSize, noOfCoeff);
        particle(i).Cost=costFunction(particle(i).Position,desiredFilter_h);
        particle(i).Best.Position=particle(i).Position;
        particle(i).Best.Cost=particle(i).Cost;
        if particle(i).Best.Cost<GlobalBest.Cost
            GlobalBest=particle(i).Best;
        end
    end
    
    %array to hold best value in each iterations
    BestCosts=[1 MaxIt];
    
    % Main loop of PSO
    for it=1:MaxIt
        for i=1:nPop
            for j = 1:noOfCoeff
                particle(i).Velocity(j) = w*particle(i).Velocity(j) ...
                    + c1*rand*(particle(i).Best.Position(j) - particle(i).Position(j)) ...
                    + c2*rand*(GlobalBest.Position(j) - particle(i).Position(j));
            end
            %particle(i).Velocity=w*particle(i).Velocity ...
            %    + c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) ...
            %    + c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
            particle(i).Velocity=max(particle(i).Velocity, MinVelocity);
            particle(i).Velocity=min(particle(i).Velocity,MaxVelocity);
            particle(i).Position=particle(i).Position+particle(i).Velocity;
            particle(i).Position=max(particle(i).Position,VarMin);
            particle(i).Position=min(particle(i).Position,VarMax);
            particle(i).Cost=costFunction(particle(i).Position,desiredFilter_h);
            if particle(i).Cost<particle(i).Best.Cost
                particle(i).Best.Position=particle(i).Position;
                particle(i).Best.Cost=particle(i).Cost;
                if particle(i).Best.Cost<GlobalBest.Cost
                    GlobalBest=particle(i).Best;
                end
            end
        end
        BestCosts(it)=GlobalBest.Cost;
        if ShowIterInfo
            hold all
            [temp_y,temp_x] = freqz(GlobalBest.Position,1 , 'whole', 1000);
            % Check if first entry
            if(isfirstPrint)
                delete(mt);
            end
            mt = plot(temp_x/pi,20*log10(abs(temp_y)));
            title({['Interation #: ' num2str(it) ' (Population Size: ' num2str(nPop) ')']});
            xlabel('w ( x pi)');
            ylabel('|H(jw)| (dB)');
            hold off
            drawnow
            isfirstPrint = true;
            disp(['Iteration' num2str(it) ': Best Cost: ' num2str(BestCosts(it))]);
        end
        w=w*wdamp;
    end
    out.pop=particle;
    out.BestSol=GlobalBest;
    out.BestCosts=BestCosts;