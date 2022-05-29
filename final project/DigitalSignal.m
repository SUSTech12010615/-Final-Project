function [DemodulatedBits] = DigitalSignal(Bits,SNR0)
%数字基带传输模拟，输入参数为0、1组成的比特串与信噪比SNR（AWGN信道）
%   此处显示详细说明
a = Bits;
%通过循环将0、1比特串转化为1、-1的映射
t=size(a);
b=[zeros(1,t(2))];
for k=1:t(2)
    if(a(k)==0)
        b(k)=-1;
    else if(a(k)==1)
        b(k)=1;
    end
    end
end
%上采样得到冲激信号获取，设定冲激串周期
pulse = upsample(b,1000);
t0=(1:length(pulse)+599).*(5*10^(-3));
%获取采样函数调制
x0=linspace(-3,3,600);
sample=sinc(x0);
%两个信号进行卷积得到基带调制信号
modu=conv(pulse,sample);

%设定信噪比生成高斯白噪声
SNR=SNR0;
noise=randn(size(modu))*std(modu)/db2mag(SNR);
modu=modu+noise;

%确定采样起始部分
Sampsinc = (601-1)/2;
%通过采样因子得到对应位置的冲激信号
De0=[zeros(1,t(2))];
for k=1:t(2)
   De0(k)=modu(Sampsinc+(k-1)*1000);
end
%将冲激信号映射到比特串
De1=[zeros(1,t(2))];
for k=1:t(2)
    if(De0(k)<0)
        De1(k)=0;
    else if(a(k)>0)
        De1(k)=1;
    end
    end
end

DemodulatedBits = De1;
end

