clear all;
close all;

mu1 = [-1 1];
Sigma1 = [2.5 1.6; 1.6 2.5];
mu2 = [1.5 1.5];

% % test set  
N = 1000;
N1 = 1/10 * N;
N2 = 9/10 * N;
test1 = mvnrnd(mu1, Sigma1, N1);
test2 = mvnrnd(mu2, Sigma1, N2);
one_labels = ones(N1,1);
two_labels = zeros(N2,1);

test1l = [test1 one_labels];
test2l = [test2 two_labels];


test = [test1l; test2l];
disp(test);

figure(3);
plot(test1(:,1), test1(:,2),'+');
hold;
plot(test2(:,1), test2(:,2),'o');

g1 = discriminantFunction(test(:,1:2), mu1, Sigma1, N1/N);
g2 = discriminantFunction(test(:,1:2), mu2, Sigma1, N2/N);
g = g1-g2;

figure;
plot(g);

t_count = 0;
for i = 1:N
    if((g(i)>0) &&(test(i,3) == 1))
        t_count = t_count + 1;
    end
    if((g(i)<0) &&(test(i,3) == 0))
        t_count = t_count + 1;
    end
end
disp('True classifications:');
disp(t_count/N);

x_axis = get(gca,'xLim'); y_axis = get(gca,'yLim');
x_vect = linspace(x_axis(1),x_axis(2),60);
y_vect = linspace(y_axis(1),y_axis(2),60);
[X Y] = meshgrid(x_vect, y_vect);
imagesc(X(:),Y(:),(g2-g1)');
plot(test1(:,1),test1(:,2),'+');
plot(test2(:,1),test2(:,2),'o');
[C,h]=contour(X,Y,(g2-g1)',[0 0]);
set(h,'ShowText','on','EdgeColor',[1 1 1]);
