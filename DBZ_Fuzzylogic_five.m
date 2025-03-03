clc; 
clear all ; 
close all ;



A.X = [1 2 3];
A.mu = [0.5 1 0.5];

B.X = [3 4 5 6 7];
B.mu = [0.2 0.5 1 0.5 0.1];

C.X = 0:12;
C.mu = zeros(size(C.X));

for x = C.X
    
    i = find(C.X == x);
    C.mu(i)= 0;
    for x1 = A.X
        i1 = find(A.X == x1);
        for x2 = B.X
            i2 = find(B.X == x2) ;
        if (x1+x2 == x)
          
            C.mu(i) = C.mu(i)+ A.mu(i1)*B.mu(i2);
            
        end
    
        end
    end
end

figure (1) 

subplot (3,1,1);
stem(A.X,A.mu);
title('A');
subplot (3,1,2);
stem(B.X,B.mu);
title('B');
subplot (3,1,3);
stem(C.X,C.mu);
stem(A.X,A.mu);
title('C = A+B')