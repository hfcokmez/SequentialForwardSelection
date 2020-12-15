function [accuracy] = hesapla(testData,class1,class2,class3,class4,featureSet)

notZero=true;
countzero=0;
for i=1:size(featureSet,2)
    if featureSet(1,i)==0
        countzero=countzero+1;
    end
end
if countzero==size(featureSet,2)
    notZero=false;
end

if(notZero)
%sample partition
t=1;
partValues=zeros(1,1);
for i=1:size(featureSet,2)
    if featureSet(1,i)==1
        partValues(1,t)=i;
        t=t+1;
    end
end
for i=1:size(partValues,2)
    newClass1(:,i)=class1(:,partValues(:,i));
    newClass2(:,i)=class2(:,partValues(:,i));
    newClass3(:,i)=class3(:,partValues(:,i));
    newClass4(:,i)=class4(:,partValues(:,i));
    newtestData(:,i)=testData(:,partValues(:,i));
end

%Means of training datas
m1=mean(newClass1,1);
m2=mean(newClass2,1);
m3=mean(newClass3,1);
m4=mean(newClass4,1);

%Classification works here:
classGuess=zeros(size(newtestData,1),2);
for i=1:size(newtestData,1)
    if (gaussdens(m1',cov(newClass1),newtestData(i,:)')>gaussdens(m2',cov(newClass2),newtestData(i,:)')  && gaussdens(m1',cov(newClass1),newtestData(i,:)')>gaussdens(m3',cov(newClass3),newtestData(i,:)') && gaussdens(m1',cov(newClass1),newtestData(i,:)')>gaussdens(m4',cov(newClass4),newtestData(i,:)'))                                                        
        classGuess(i,1)=1;
        classGuess(i,2)=gaussdens(m1',cov(newClass1),newtestData(i,:)');
    elseif(gaussdens(m2',cov(newClass2),newtestData(i,:)')>gaussdens(m1',cov(newClass1),newtestData(i,:)') && gaussdens(m2',cov(newClass2),newtestData(i,:)')>gaussdens(m3',cov(newClass3),newtestData(i,:)') && gaussdens(m2',cov(newClass2),newtestData(i,:)')>gaussdens(m4',cov(newClass4),newtestData(i,:)'))
        classGuess(i,1)=2;
        classGuess(i,2)=gaussdens(m2',cov(newClass2),newtestData(i,:)');
    elseif(gaussdens(m3',cov(newClass3),newtestData(i,:)')>gaussdens(m1',cov(newClass1),newtestData(i,:)') && gaussdens(m3',cov(newClass3),newtestData(i,:)')>gaussdens(m2',cov(newClass2),newtestData(i,:)') && gaussdens(m3',cov(newClass3),newtestData(i,:)')>gaussdens(m4',cov(newClass4),newtestData(i,:)'))
        classGuess(i,1)=3;
        classGuess(i,2)=gaussdens(m3',cov(newClass3),newtestData(i,:)');
    elseif(gaussdens(m4',cov(newClass4),newtestData(i,:)')>gaussdens(m1',cov(newClass1),newtestData(i,:)') && gaussdens(m4',cov(newClass4),newtestData(i,:)')>gaussdens(m2',cov(newClass2),newtestData(i,:)') && gaussdens(m4',cov(newClass4),newtestData(i,:)')>gaussdens(m3',cov(newClass3),newtestData(i,:)'))
        classGuess(i,1)=4;
        classGuess(i,2)=gaussdens(m4',cov(newClass4),newtestData(i,:)');
    end
end

%Accuracy test are done here:
accuracyCount=0;
for i=1:size(classGuess,1)
    if classGuess(i,1)==1 && i<=80
        accuracyCount=accuracyCount+1;
    elseif classGuess(i,1)==2 && 80<i && i<=160
        accuracyCount=accuracyCount+1;
    elseif classGuess(i,1)==3 && 160<i && i<=240
        accuracyCount=accuracyCount+1;
    elseif classGuess(i,1)==4 && 240<i && i<=320
        accuracyCount=accuracyCount+1;
    end
    
end

accuracy=accuracyCount/size(classGuess,1);
else
accuracy=0;
end

end

