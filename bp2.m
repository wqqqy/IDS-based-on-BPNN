load test
load abnormal
load normal


x=test';
%c=mapminmax(x,0,1);
%x=c;
y=zeros(1,5000);
for i=1:5000
    y(i)=1;
end

xi=mapminmax(x, 0, 1);
yo=mapminmax(y, 0, 1);

tmp=[0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1];
out=[0 1;];
bpnet=newff(tmp,out,7,{},'traingd');%构建网络
bpnet.trainParam.goal=0.00001;  %设定训练误差
bpnet.trainParam.epochs=100; %设定最大训练步数;
bpnet.trainParam.show=10; %每间隔100步显示一次训练结果
bpnet.trainParam.lr=0.05; %学习速率0.05
bpnet.trainParam.lr_inc = 1.05;
[bpnet]=train(bpnet,xi,yo);  %训练网络




%y2=sim(bpnet,x);    %输出数据
%p=[0 1 1 1 1032 0 0 0 511 511 0.00 0.00 1.00 255];
p=[0 1 1 1 219 0 0 0 6 6 0.00 0.00 1.00 39;
   0 1 1 1 141 0 0 0 12 17 0.00 0.00 1.00 12];





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55统计误报率
 %a1=mapminmax(test,0,1);
% p1=a1'
 p1=normal';
 pp=mapminmax(p1, 0, 1);
r1=sim(bpnet,pp);

%display(r');

[s1 , s2] = size( r1 ) ;
hitNum1 = 0 ;
for i = 1 : s2
    if(r1(i)>=0.8 && r1(i)<=1.2)
        hitNum1 = hitNum1 + 1 ; 
    end
end


%%%%%%%%%%%%%%%检测率漏报率
 %a2=mapminmax(wubao,0,1);
 %p2=a2'
 p2=abnormal';
 pp2=mapminmax(p2, 0, 1);
r2=sim(bpnet,pp2);

%display(r');
[s1 , s2] = size( r2 ) ;
hitNum2 = 0 ;
for i = 1 : s2
    if(r2(i)>=0.8 && r2(i)<=1.2)
        hitNum2 = hitNum2 + 1 ; 
    end
end
sprintf('误报率是 %3.3f%%',(100 *  (900 - hitNum1) / 900))
sprintf('检测率是 %3.3f%%',(100 * (900 - hitNum2) / 900))
sprintf('漏报率是 %3.3f%%',100 * hitNum2 / 900)






