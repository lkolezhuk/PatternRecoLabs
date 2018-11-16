function [ accuracy ] = CheckAccuracy( data_real, classification_results )
%Gets accuracy of the performance of the classifier

true_class_c = 0;
for i=1:size(data_real,1)
    if(data_real(i,3) == classification_results(i))
        true_class_c = true_class_c + 1;
    end
end
accuracy = true_class_c / size(classification_results,1);

end

