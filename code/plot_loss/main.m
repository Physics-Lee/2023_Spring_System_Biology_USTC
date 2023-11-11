folder_name = 'C:\Users\11097\Desktop';
file_name = 'DLC_resnet101_AfterCutJun19shuffle1_2000-results.csv';
full_path = fullfile(folder_name,file_name);
A = readmatrix(full_path);
iteration_time = A(2:size(A,1),2);
RMSE_train = A(2:size(A,1),5);
RMSE_test = A(2:size(A,1),6);
name_of_DNN = 'ResNet101';
plot_loss(iteration_time,RMSE_train,RMSE_test,name_of_DNN);

output_file_name = [name_of_DNN '.png'];
output_full_path = fullfile(folder_name,output_file_name);
saveas(gcf,output_full_path);