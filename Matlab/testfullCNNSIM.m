clc;
clear all;

%block=15;%15
pooling_layer=5;%5
pic_num=125;%125
a0=3;
T0=10;
%k1=1;
%k2=1;
dir='D:\inNBU\Project\image_source\TID\tid2013\JPEG compression\features';
Data = [];
%for i=1:block
for j=1:pic_num
    Ed=0;
    Er=0;
    for k=1:pooling_layer
        temp_dis=double(imread([dir,'\distort\pool',num2str(k),'\',num2str(j),'.png']));
        temp_ref=double(imread([dir,'\reference\pool',num2str(k),'\',num2str(ceil(j/5)),'.png']));
        temp_Ed=(power(temp_dis,2));
        Ed=Ed+mean(temp_Ed(:));
        temp_Er=(power(temp_ref,2));
        Er=Er+mean(temp_Er(:));
    end
        %Ed=mean(Ed(:));
        %Er=mean(Er(:));
    Scnn=0;
    for m=1:pooling_layer
        img_dis=double(imread([dir,'\distort\pool',num2str(k),'\',num2str(j),'.png']));
        img_ref=double(imread([dir,'\reference\pool',num2str(k),'\',num2str(ceil(j/5)),'.png']));
        Edp=power(img_dis,2);
        Erp=power(img_ref,2);
        Edp=mean(Edp(:));
        Erp=mean(Erp(:));
        ak=a0+Edp/Ed+Erp/Er;
        Scnn_xy=power((2 * img_dis(:,:,1) .* img_ref(:,:,1) + T0) ./ (img_dis(:,:,1).^2 + img_ref(:,:,1).^2 + T0),ak);
        %testscnn=mean(Scnn_xy(:));
        Scnn=Scnn+0.2*mean(Scnn_xy(:));
    end
    Data=[Data Scnn;]
end
%end
Data=reshape(Data',125,1);
xlswrite('test3.xlsx',Data);
         