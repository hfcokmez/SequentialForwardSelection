clear all
close all
clc
load('sequentialDataset.mat');

c1=classes(1:160,1:8);
c2=classes(161:320,1:8);
c3=classes(321:480,1:8);
c4=classes(481:640,1:8);

c1Train=c1(1:80,1:8);
c2Train=c2(1:80,1:8);
c3Train=c3(1:80,1:8);
c4Train=c4(1:80,1:8);

cTest(1:80,1:8)=c1(81:160,1:8);
cTest(81:160,1:8)=c2(81:160,1:8);
cTest(161:240,1:8)=c3(81:160,1:8);
cTest(241:320,1:8)=c4(81:160,1:8);

bestFeature=zeros(1,size(classes,2));
bestfromLayer=zeros(1,size(classes,2));
lastBest=zeros(1,size(classes,2));
answerFeature=zeros(1,size(classes,2));

for i=1:size(bestfromLayer,2)-1
    best=1;
    for j=1:size(bestfromLayer,2)
        if best==1
            if bestfromLayer(1,j)==0
                bestfromLayer(1,j)=1;
                best=0;
            end
        %Diðer samplelarla karþýlaþtýrma:    
        else
            if  lastBest(1,j)==0
                lastBest(1,j)=1;
                if(hesapla(cTest,c1Train,c2Train,c3Train,c4Train,bestfromLayer) < hesapla(cTest,c1Train,c2Train,c3Train,c4Train,lastBest))
                    bestfromLayer=lastBest;
                end
                lastBest(1,j)=0;
            end
        end
        if j==size(bestfromLayer,2)
            if (hesapla(cTest,c1Train,c2Train,c3Train,c4Train,bestfromLayer)>hesapla(cTest,c1Train,c2Train,c3Train,c4Train,answerFeature))
                answerFeature=bestfromLayer;
            end
            lastBest=bestfromLayer;
        end
    end
end

disp(answerFeature);