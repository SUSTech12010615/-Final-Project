function y = rgb(x,m,n)
r=zeros(m,n);
r(1)=x;
for i=2:m*n
    r(i)=1-2*r(i-1)^2;
end
for i=1:m*n
    r(i)=mod(round(r(i)*95145146),256);
end

g=zeros(m,n);
g(1)=x+0.5;
for i=2:m*n
    g(i)=1-2*g(i-1)^2;
end
for i=1:m*n
    g(i)=mod(round(g(i)*5621875),256);
end

b=zeros(m,n);
b(1)=x-0.5;
for i=2:m*n
    b(i)=1-2*b(i-1)^2;
end
for i=1:m*n
    b(i)=mod(round(b(i)*35645154),256);
end

y=zeros(m,n,3);
y=cat(3,r,g,b);
y=uint8(y);
end

