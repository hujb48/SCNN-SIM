clc;
clear all;

block=15;%15
pooling_layer=5;%5
pic_num=125;%125
a0=2;
T0=10;
%k1=1;
%k2=1;
dir='D:\inNBU\Project\image_source\block image\TID2013\JPEG\model\';
Data = [];
data1 = [];
data2 = [];
data3 = [];
data4 = [];
data5 = [];
for i=1:block
    for j=1:pic_num
        Ed=0;
        Er=0;
        for k=1:pooling_layer
            temp_dis=double(imread([dir,num2str(i),'\features\pool',num2str(k),'\',num2str(j),'-inputs.png']));
            temp_ref=double(imread([dir,num2str(i),'\features\pool',num2str(k),'\',num2str(j),'-outputs.png']));
            temp_Ed=(power(temp_dis,2));
            Ed=Ed+mean(temp_Ed(:));
            temp_Er=(power(temp_ref,2));
            Er=Er+mean(temp_Er(:));
        end
        %Ed=mean(Ed(:));
        %Er=mean(Er(:));
        Scnn=0;
        for m=1:pooling_layer
            img_dis=double(imread([dir,num2str(i),'\features\pool',num2str(m),'\',num2str(j),'-inputs.png']));
            img_ref=double(imread([dir,num2str(i),'\features\pool',num2str(m),'\',num2str(j),'-outputs.png']));
            Edp=power(img_dis,2);
            Erp=power(img_ref,2);
            Edp=mean(Edp(:));
            Erp=mean(Erp(:));
            ak=a0+Edp/Ed+Erp/Er;
            Scnn_xy=power((2 * img_dis(:,:,1) .* img_ref(:,:,1) + T0) ./ (img_dis(:,:,1).^2 + img_ref(:,:,1).^2 + T0),ak);
            %testscnn=mean(Scnn_xy(:));
            if m==1
                Scnn=Scnn+0.3*mean(Scnn_xy(:));
                flag1=mean(Scnn_xy(:));
                data1=[data1 flag1];
            end
            if m==2
                Scnn=Scnn+0.1*mean(Scnn_xy(:));
                flag2=mean(Scnn_xy(:));
                data2=[data2 flag2];
            end
            if m==3
                Scnn=Scnn+0.1*mean(Scnn_xy(:));
                flag3=mean(Scnn_xy(:));
                data3=[data3 flag3];
            end
            if m==4
                Scnn=Scnn+0.1*mean(Scnn_xy(:));
                flag4=mean(Scnn_xy(:));
                data4=[data4 flag4];
            end
            if m==5
                Scnn=Scnn+0.4*mean(Scnn_xy(:));
                flag5=mean(Scnn_xy(:));
                data5=[data5 flag5];
            end
        end
        Data=[Data Scnn]
    end
end
Data=reshape(Data',125,15);
data1=reshape(data1',125,15);
data2=reshape(data2',125,15);
data3=reshape(data3',125,15);
data4=reshape(data4',125,15);
data5=reshape(data5',125,15);
xlswrite('D:\inNBU\Project\SVR_FU\svr\TID2013DataJPEG_2_31114.xlsx',Data);
xlswrite('D:\inNBU\Project\SVR_FU\svr\1.xlsx',data1);
xlswrite('D:\inNBU\Project\SVR_FU\svr\2.xlsx',data2);
xlswrite('D:\inNBU\Project\SVR_FU\svr\3.xlsx',data3);
xlswrite('D:\inNBU\Project\SVR_FU\svr\4.xlsx',data4);
xlswrite('D:\inNBU\Project\SVR_FU\svr\5.xlsx',data5);
        