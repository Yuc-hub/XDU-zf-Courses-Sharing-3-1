% DTMF version commande en ligne
% Auteur:
% Date: 2024/11/19
%

%Initialisation
clear all
close all

% Frequence  et Periode d'閏hantillonnage
Fe = 4000;
Te = 1/Fe;

%Simulation de la touche press閑 sur 2 secondes
%nombre d'閏hantillon sur 2 secondes
Nech = 2/Te;
n = 0:Te:(Nech-1)*Te;

% Simulation de la touche 5
fb1 = 852;
fh2 = 1477;
sin_fb1 = sin(2*pi*fb1*n);
sin_fh2 = sin(2*pi*fh2*n);

sigin = sin_fb1 + sin_fh2;

%% Calcul des filtres
Rp= 0.1;
Rs = 20;

% calcul du 1er filtre
Wp1 = [690*(2/Fe) 704*(2/Fe)]; % wp1 = [fp1*(2/Fe) fp2*(2/Fe)]
                               % *(2/Fe) -> pour nornmalisation
Ws1 = [625*(2/Fe) 770*(2/Fe)];
[N1, Wn1] = buttord(Wp1, Ws1, Rp, Rs); %ici a besoin de valeur entre [0,1]
                                       %buttord 函数根据指定的通带和阻带的规范计算最低滤波器阶数 N1 和截止频率 Wn1
[b1,a1] = butter(N1,Wn1);

% calcul du 2eme filtre
Wp2 = [765*(2/Fe) 775*(2/Fe)];
Ws2 = [700*(2/Fe) 850*(2/Fe)];
[N2, Wn2] = buttord(Wp2, Ws2, Rp, Rs);
[b2,a2] = butter(N2,Wn2);

% calcul du 3eme filtre
Wp3 = [840*(2/Fe) 860*(2/Fe)];
Ws3 = [770*(2/Fe) 940*(2/Fe)];
[N3, Wn3] = buttord(Wp3, Ws3, Rp, Rs);
[b3,a3] = butter(N3,Wn3);

% calcul du 4eme filtre
Wp4 = [930*(2/Fe) 950*(2/Fe)];
Ws4 = [850*(2/Fe) 1030*(2/Fe)];
[N4, Wn4] = buttord(Wp4, Ws4, Rp, Rs);
[b4,a4] = butter(N4,Wn4);

% calcul du 5eme filtre
Wp5 = [1200*(2/Fe) 1220*(2/Fe)];
Ws5 = [1090*(2/Fe) 1330*(2/Fe)];
[N5, Wn5] = buttord(Wp5, Ws5, Rp, Rs);
[b5,a5] = butter(N5,Wn5);

% calcul du 6eme filtre
Wp6 = [1326*(2/Fe) 1346*(2/Fe)];
Ws6 = [1210*(2/Fe) 1450*(2/Fe)];
[N6, Wn6] = buttord(Wp6, Ws6, Rp, Rs);
[b6,a6] = butter(N6,Wn6);

% calcul du 7eme filtre
Wp7 = [1437*(2/Fe) 1457*(2/Fe)];
Ws7 = [1330*(2/Fe) 1560*(2/Fe)];
[N7, Wn7] = buttord(Wp7, Ws7, Rp, Rs);
[b7,a7] = butter(N7,Wn7);



%% Filtrage du signal d'entree par les 7 filtres

sigout1 = filter(b1,a1,sigin);
sigout2 = filter(b2,a2,sigin);
sigout3 = filter(b3,a3,sigin);
sigout4 = filter(b4,a4,sigin);
sigout5 = filter(b5,a5,sigin);
sigout6 = filter(b6,a6,sigin);
sigout7 = filter(b7,a7,sigin);

%% Calcul du filtre passe bas de 50Hz et filtrage de la valeur absolue

% Calcul du filtre passe-bas de frequence de coupure 50Hz
Wp_lp = 40*(2/Fe);
Ws_lp = 320*(2/Fe);
[N_lp, Wn_lp] = buttord(Wp_lp, Ws_lp, Rp, Rs);
[b_lp,a_lp] = butter(N_lp,Wn_lp);

% Filtrage de la valeur absolue
sig1 = filter(b_lp,a_lp,abs(sigout1));
sig2 = filter(b_lp,a_lp,abs(sigout2));
sig3 = filter(b_lp,a_lp,abs(sigout3));
sig4 = filter(b_lp,a_lp,abs(sigout4));
sig5 = filter(b_lp,a_lp,abs(sigout5));
sig6 = filter(b_lp,a_lp,abs(sigout6));
sig7 = filter(b_lp,a_lp,abs(sigout7));

%%
figure;
subplot(2, 1, 1); % 创建一个 2x1 的子图，当前为第一个子图
plot(n, sigout1);

subplot(2, 1, 2); % 创建一个 2x1 的子图，当前为第一个子图
plot(n, sig1);
%% 
figure; % 创建一个新的图形窗口

% % 绘制 sig1
% subplot(2, 1, 1); % 创建一个 2x1 的子图，当前为第一个子图
% plot(n, sig1);
% title('Signal 1');
% xlabel('Sample');
% ylabel('Amplitude');
% 
% % 绘制 sig3
% subplot(2, 1, 2); % 当前为第二个子图
% plot(n, sig3);
% title('Signal 3');
% xlabel('Sample');
% ylabel('Amplitude');
% 
% % 绘制 sig3
% subplot(2, 1, 2); % 当前为第二个子图
% plot(n, sig4);
% title('Signal 3');
% xlabel('Sample');
% ylabel('Amplitude');
% 
% % 绘制 sig3
% subplot(2, 1, 2); % 当前为第二个子图
% plot(n, sig3);
% title('Signal 3');
% xlabel('Sample');
% ylabel('Amplitude');
% 
% % 添加网格以便更好地观察信号
% grid on;

%% Seuillage
for i=1:Nech
    if sig1(i)>0.4  %判断大于某一值置1
        sig1_thr(i)=1;
    else sig1_thr(i)=0;
    end
    if sig2(i)>0.4
        sig2_thr(i)=1;
    else sig2_thr(i)=0;
    end
    if sig3(i)>0.4
        sig3_thr(i)=1;
    else sig3_thr(i)=0;
    end
    if sig4(i)>0.4
        sig4_thr(i)=1;
    else sig4_thr(i)=0;
    end
    if sig5(i)>0.4
        sig5_thr(i)=1;
    else sig5_thr(i)=0;
    end
    if sig6(i)>0.4
        sig6_thr(i)=1;
    else sig6_thr(i)=0;
    end
    if sig7(i)>0.4
        sig7_thr(i)=1;
    else sig7_thr(i)=0;
    end
end

%% Calcul des signaux lignes et signaux colonnes (Fonctions Fcn dans le sch閙a)

sig_line = sig1_thr + 2*sig2_thr + 3*sig3_thr + 4*sig4_thr;
sig_rows = sig5_thr + 2*sig6_thr + 3*sig7_thr;


%% Mise en place de la LUT

if max(sig_line)==1
    if max(sig_rows)==1
        display('touche 1 pressee');
    elseif max(sig_rows)==2
            display('touche 2 pressee');
    elseif max(sig_rows)==3
             display('touche 3 pressee');
    end
end
if max(sig_line)==2
    if max(sig_rows)==1
        display('touche 4 pressee');
    elseif max(sig_rows)==2
            display('touche 5 pressee');
    elseif max(sig_rows)==3
             display('touche 6 pressee');
    end
end
if max(sig_line)==3
    if max(sig_rows)==1
        display('touche 7 pressee');
    elseif max(sig_rows)==2
            display('touche 8 pressee');
    elseif max(sig_rows)==3
             display('touche 9 pressee');
    end
end
if max(sig_line)==4
    if max(sig_rows)==1
        display('touche * pressee');
    elseif max(sig_rows)==2
            display('touche 0 pressee');
    elseif max(sig_rows)==3
             display('touche # pressee');
    end
end
