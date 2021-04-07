%   Authors: Li Xiaosong, Zhou Fuqiang, et al.   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Xiaosong Li,Fuqiang Zhou, Haishu Tan. Multimodal Medical Image Fusion Based on Joint Bilateral
%         Filter and Local Gradient Energy [J].preprint to Information Sciences.
% Beihang university,
% Last update:12-23-2020

close all; clear all; clc;
A=imread('01 MR-T1.tif');  B=imread('01 MR-T2.tif');     % source images
A = im2double(A);    B = im2double(B);   
figure,imshow(A);    figure,imshow(B);

%% parameters          
s=3;    r=0.05;   N=4;    T=21; 

tic
%% image decomposition
E1 = RollingGuidanceFilter(A,s,r,1);    
E2 = RollingGuidanceFilter(B,s,r,1);
S1= A-E1;  S2= B-E2;           
LGE1=str_tensor_map(S1).*local_energy(S1,N);         
LGE2=str_tensor_map(S2).*local_energy(S2,N);
map=(LGE1>LGE2);
map=majority_consist_new(map,T);        
FS=map.*S1+~map.*S2;                   % fused structure layer                
map2=abs(E1>E2);
FE= E1.*map2+~map2.*E2;                % fused energy layer               
F=FE+FS;                               % fused result                              
toc
figure,imshow(F);
