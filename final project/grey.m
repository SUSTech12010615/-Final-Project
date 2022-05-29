function y = grey(x,m,n)
y=zeros(m,n);
y(1)=x;
for i=2:m*n
    y(i)=1-2*y(i-1)^2;
end
for i=1:m*n
    y(i)=mod(round(y(i)*54616546),256);
end
y=uint8(y);
end

