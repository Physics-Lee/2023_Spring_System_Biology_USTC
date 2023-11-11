function plot_loss(iteration_time,RMSE_train,RMSE_test,name_of_DNN)
figure;
hold on;
plot(iteration_time,RMSE_train,'blue-o');
plot(iteration_time,RMSE_test,'red-o');
xlabel('iteration time');
ylabel('Root Mean Square Error of pixels');
legend('train set','test set');
title(name_of_DNN);
end