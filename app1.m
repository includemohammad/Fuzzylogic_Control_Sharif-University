clc;
clear;
close all;

%% 0: Generate Data

f=@(x) sin(x);

xmin=0;
xmax=2*pi;
P=40;

x=linspace(xmin,xmax,P)';

y=f(x);
plot(x,y)

%% 1: Create Membership Functions

nA=20;
A=CreateMembershipFunctions(x,nA,'gaussmf');

nB=10;
B=CreateMembershipFunctions(y,nB,'gaussmf');

%% 2: Create Rules Matrix

S=zeros(nA,nB);

%% 3: Calculate Rank of Rules

for ai=1:nA
    amf=A{ai,1};
    aparam=A{ai,2};
    
    for bi=1:nB
        bmf=B{bi,1};
        bparam=B{bi,2};
        
        s=zeros(1,P);
        for p=1:P
            s(p)=feval(amf,x(p),aparam)*feval(bmf,y(p),bparam);
        end
        
        S(ai,bi)=max(s);
        
        % S(ai,bi)=sum(s);
        
    end
end

%% 4: Delete Extra Rules

[~, ind]=max(S,[],2)

Rules=[(1:nA)' ind]

Rules(:,3)=1
Rules(:,4)=1


%% 5: Create FIS

fis=newfis('Lookup Table FIS','mamdani');

fis=addvar(fis,'input','x',[min(x) max(x)]);
for ai=1:nA
    fis=addmf(fis,'input',1,['A' num2str(ai)],A{ai,1},A{ai,2});
end

fis=addvar(fis,'output','y',[min(y) max(y)]);
for bi=1:nB
    fis=addmf(fis,'output',1,['B' num2str(bi)],B{bi,1},B{bi,2});
end

fis=addrule(fis,Rules);

%% Test FIS

% fuzzy(fis);

xx=linspace(xmin,xmax,1000)';

yy=f(xx);

yyhat=evalfis(xx,fis);

ee=yy-yyhat;

figure;

subplot(2,2,[1 2]);
plot(xx,yy,'b');
hold on;
plot(xx,yyhat,'r');
xlabel('x');
ylabel('y');
legend('Target Values','Output Values');

subplot(2,2,3);
plot(xx,ee);
xlabel('x');
ylabel('e');

subplot(2,2,4);
histfit(ee,100);


