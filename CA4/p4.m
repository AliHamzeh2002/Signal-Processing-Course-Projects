train_prediction = trainedModel.predictFcn(diabetestraining);
train_accuracy = mean(table2array(diabetestraining(:, 'label')) == train_prediction);
fprintf('Training accuracy: %f\n', train_accuracy);

test_data = readtable('diabetes-validation.csv');
test_prediction = trainedModel.predictFcn(test_data);
test_accuracy = mean(table2array(test_data(:, 'label')) == test_prediction);
fprintf('Test accuracy: %f\n', test_accuracy);
