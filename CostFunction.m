function error=CostFunction(currentFilterPosition,desiredFilter_h)
    [h,w] = freqz(currentFilterPosition,1,'whole',1000);
    %freqz command is used to get response of digital filters with
    %arguments as follows:-
    %freqz(a,b,'whole',c);
    %a:-numerator of transfer function
    %b:-denominator of tranfer function
    %c:- places a limit of points on unit circle in which it can return
    %answer. In this case,it finds the frequency response at 1000 points spanning
    %the complete unit circle.
    %this function returns frequency vectors at 1 point(s) ranging between 0
    %and 1000.
    %h:-correcponding frequency vector
    %w:-angular frequency vector
    h1=abs(h);%approximating h array
    h2=abs(desiredFilter_h);
    diff = (h1 - h2).^2;%matrix multiply h1 and h2 and square each one
    %error=mean(diff);%MSE error
    result=sum(diff);%add each element of array and now result is a array having one element 
    error=result.^0.5;%taking sqaure root 
end