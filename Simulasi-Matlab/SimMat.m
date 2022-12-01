%Simulasi Program Mobil Roda Dua
clc;
clear;
tic;

g=[0,0]; %Titik target
g_theta=pi/4; %Arah target

car=[-2,-2]; %Titik awal mobil
car_theta=-pi/4; %Srah awal mobil

L=0.2; %Setel jarak antara roda kecil menjadi 0,2m

Kp=0.3 ; %Parameter kecepatan pergerakan
Ki=0;
Kd=0.2;

Kpo=2; %Parameter kecepatan sudut putaran
Kio=0;
Kdo=0.1;

tstep=0.1; %Langkah waktu
t=0; %Akumulasi waktu
    
qk=[car(1)
    car(2)
    car_theta]; %Posisi dan orientasi mobil saat ini
accerrd=0; %Kesalahan posisi akumulatif
accerrt=0; %Kesalahan akumulatif dari sudut deviasi target
v=0; %Kecepatan mobil
omega=0; %Kecepatan putaran mobil 
carp=[qk(1),qk(2)]; %Posisi mobil saat ini
delta_dis=norm(carp-g); %jarak dari titik akhir
delta_theta_offset=atan((g(2)-qk(2))/(g(1)-qk(1)))-qk(3); %Sudut deviasi target
deltadisp=0; %Jarak pergerakan dari titik sebelumnya
deltatp=0; %Sudut rotasi dari titik sebelumnya

i=0;

figure(1); %Gambarlah titik
r=0.05;
alpha=0:pi/50:2*pi;
x=qk(1)+r*cos(alpha); 
y=qk(2)+r*sin(alpha); 
plot(x,y,"-");
fill(x,y,"b");
grid on;
hold on;

alpha=0:pi/50:2*pi; %Menggambar titik
x=g(1)+r*cos(alpha); 
y=g(2)+r*sin(alpha); 
plot(x,y,"-");
fill(x,y,"r");
hold on;
x1=xlabel('arah x');
x2=ylabel('arah y');
title('Jalur Pergerakan Mobil');

%Bagian Pertama: bergerak dari titik awal ke titik target
while delta_dis>0.01
    
    t=t+tstep;
    i=i+1;
    vot(i,1)=t; %Titik waktu deposit
    ptt(i,1)=t;

    axis([-4 2 -4 2]); %Diperlukan untuk mengubah area tampilan saat mengubah titik target untuk mendapatkan sumbu efek tampilan yang lebih baik
    axis equal;
        
    carp=[qk(1),qk(2)]; %Koordinat mobil saat ini
    delta_dis=norm(carp-g); %Jarak dari titik akhir
    accerrd=accerrd+delta_dis;
          
    if g(1)>qk(1) %Sudut deviasi target perlu didiskusikan sesuai dengan posisi target dan sudut yang terbentuk dengan posisi mobil saat ini
        delta_theta_offset=atan((g(2)-qk(2))/(g(1)-qk(1)))-qk(3);
    elseif g(2)>qk(2)
            delta_theta_offset=atan((g(2)-qk(2))/(g(1)-qk(1)))+pi-qk(3);
    else
        delta_theta_offset=atan((g(2)-qk(2))/(g(1)-qk(1)))-pi-qk(3);
    end
    accerrt=accerrt+delta_theta_offset;
    
    while delta_theta_offset>pi || delta_theta_offset<=-pi  %Memproses sudut offset target sehingga jatuh di (-pi,pi]
    if delta_theta_offset>pi
        delta_theta_offset=delta_theta_offset-2*pi;
    end
    if delta_theta_offset<=-pi
        delta_theta_offset=delta_theta_offset+2*pi;
    end
    end
    
    v=Kp*delta_dis+Ki*tstep*accerrd+Kd*(delta_dis-deltadisp)/tstep; %kecepatan penyesuaian PID
    
    omega=Kpo*delta_theta_offset+Kio*tstep*accerrt+Kdo*(delta_theta_offset-deltatp)/tstep; %Sudut penyesuaian PID
    
    Vr=(2*v+L*omega)/2; %ͨSelesaikan kecepatan linier roda kiri dan roda kanan melalui persamaan gerak
    Vl=(2*v-L*omega)/2;
    
    while Vr>0.5 || Vl>0.5 || Vr<-0.5 || Vl<-0.5 %Vr Vl batas
       Vr=Vr*0.9;
       Vl=Vl*0.9;
    end
        
    v=(Vr+Vl)/2; %Solusi balik untuk mendapatkan kecepatan dan kecepatan sudut mobil
    omega=(Vr-Vl)/L;
    
    vot(i,3)=omega; %Disimpan dalam kecepatan sudut mobil pada titik waktu saat ini
    vot(i,2)=v; %Disimpan dalam kecepatan mobil pada titik waktu saat ini
    
    deltadisp=delta_dis; %Menyimpan jarak saat ini dari titik target dan sudut offset, dan bersiap untuk siklus berikutnya menggunakan
    deltatp=delta_theta_offset;
    
    qkp=qk;
    qk=qk+[v*tstep*cos(qk(3))  %Perbarui posisi saat ini
           v*tstep*sin(qk(3))
           omega*tstep];
    
    figure(1);
    plot([qkp(1),qk(1)],[qkp(2),qk(2)],"-r",'LineWidth',0.5); %Menggambar jalur
    hold on;
    plot(qk(1),qk(2),"o",'MarkerEdgeColor','g',... %Menggambar setiap titik pengambilan sampel
                         'MarkerFaceColor','g',...
                         'MarkerSize',2);
    hold on;
    
    ptt(i,2)=qk(3);
    ptt(i,3)=Vl;
    ptt(i,4)=Vr;
    
end

figure(2); %Gambarlah gambar bagian pertama dari kecepatan gerak dan kecepatan sudut mobil terhadap waktu t
grid on;
x1=xlabel('ʱWaktu t s');
x2=ylabel('kecepatan Perjalanan v m/s Kecepatan Sudut ω rad/s');
title('Bagian pertama adalah gambaran kecepatan perjalanan dan kecepatan sudut mobil terhadap waktu t');
hold on;

for j=1:i
    plot(vot(j,1),vot(j,2),"-o",'MarkerEdgeColor','b','MarkerFaceColor','b',"MarkerSize",2);
    plot(vot(j,1),vot(j,3),"-o",'MarkerEdgeColor','r','MarkerFaceColor','r',"MarkerSize",2);
    hold on;
end

legend('kecepatan perjalanan v','Kecepatan Sudut ω');

figure(4); %Gambarlah sudut antara mobil dan sumbu x pada waktu t
grid on;
hold on;
for j=1:i
    plot(ptt(j,1),ptt(j,2),"-o",'MarkerEdgeColor','b','MarkerFaceColor','b',"MarkerSize",2);
    hold on;
end

figure(5);; %Gambarlah bayangan kecepatan linear Vl, Vr roda kiri dan kanan mobil terhadap waktu t
grid on;
hold on;
for j=1:i
    plot(ptt(j,1),ptt(j,3),"-o",'MarkerEdgeColor','b','MarkerFaceColor','b',"MarkerSize",2);
    plot(ptt(j,1),ptt(j,4),"-o",'MarkerEdgeColor','r','MarkerFaceColor','r',"MarkerSize",2);
    hold on;
end

%Bagian kedua: Putar mobil ke arah target
dire_offset=g_theta-qk(3); %Hitung sudut simpangan arah
tp=t;
n=i;
v=0; %%Atur kecepatan mobil ke 0 setelah mencapai titik target
t=0;
i=0;

accerrdo=0; %Kesalahan kumulatif sudut deviasi arah

while abs(dire_offset)>0.001
    
    t=t+tstep;
    i=i+1;
    vo2t(i,1)=t; %Titik waktu deposit
    ptt(i+n,1)=tp+t;
    
    dire_offset=g_theta-qk(3); %Menghitung sudut deviasi arah
        
    while dire_offset>pi || dire_offset<=-pi %Memproses sudut offset sehingga masuk (-pi,pi]
    if dire_offset>pi
        dire_offset=dire_offset-2*pi;
    end
    if dire_offset<=-pi
        dire_offset=dire_offset+2*pi;
    end
    end
    
    omega=Kpo*dire_offset+Kio*tstep*accerrdo+Kdo*(dire_offset-deltatp)/tstep;
    deltatp=dire_offset;
    
    Vr=(2*v+L*omega)/2; %ͨKecepatan linier roda kiri dan roda kanan diperoleh dengan menyelesaikan persamaan gerak secara terbalik
    Vl=(2*v-L*omega)/2;
    
    while Vr>0.5 || Vl>0.5 || Vr<-0.5 || Vl<-0.5  %Membatasi Vr Vl
       Vr=Vr*0.9;
       Vl=Vl*0.9;
    end
    
    v=(Vr+Vl)/2;
    omega=(Vr-Vl)/L;
    
    vo2t(i,2)=v;
    vo2t(i,3)=omega;
    
    qkp=qk;
    qk=qk+[v*tstep*cos(qk(3)) %Perbarui posisi saat ini
           v*tstep*sin(qk(3))
           omega*tstep];
       
    ptt(i+n,2)=qk(3);   
    ptt(i+n,3)=Vl;
    ptt(i+n,4)=Vr;
    
end

figure(3); %Gambarlah grafik kecepatan sudut bagian kedua mobil terhadap waktu t
grid on;
x1=xlabel('ʱWaktu t s');
x2=ylabel('Kecepatan Perjalanan v m/s, Kecepatan Sudut ω rad/s');
title('Bagian kedua adalah gambaran kecepatan sudut mobil terhadap waktu t');
axis([-0.5 3.5 -0.5 3.5]); %Saat mengubah titik target, area tampilan perlu diubah untuk mendapatkan efek tampilan yang lebih baik
hold on;
for j=1:i
    plot(vo2t(j,1),vo2t(j,2),"-o",'MarkerEdgeColor','b','MarkerFaceColor','b',"MarkerSize",2);
    plot(vo2t(j,1),vo2t(j,3),"-o",'MarkerEdgeColor','r','MarkerFaceColor','r',"MarkerSize",2);
    hold on;
end

legend('Kecepatan Perjalanan v','Kecepatan Sudut ω ');

figure(4); %Gambarlah grafik sudut yang dibuat mobil dengan sumbu x terhadap waktu t
grid on;
x1=xlabel('ʱWaktu t s');
x2=ylabel('Sudut Arah θ rad');
title('Grafik sudut antara mobil dan sumbu x terhadap waktu t');
hold on;
for j=n+1:n+i
    plot(ptt(j,1),ptt(j,2),"-o",'MarkerEdgeColor','b','MarkerFaceColor','b',"MarkerSize",2);
    hold on;
end

figure(5); %Gambarlah bayangan kecepatan linear Vl, Vr roda kiri dan kanan mobil terhadap waktu t
grid on;
x1=xlabel('ʱWaktu t s');
x2=ylabel('Kecepatan Vl Vr m/s');
title('Gambar kecepatan linear Vl, Vr roda kiri dan kanan mobil terhadap waktu t');
hold on;
for j=n+1:n+i
    plot(ptt(j,1),ptt(j,3),"-o",'MarkerEdgeColor','b','MarkerFaceColor','b',"MarkerSize",2);
    plot(ptt(j,1),ptt(j,4),"-o",'MarkerEdgeColor','r','MarkerFaceColor','r',"MarkerSize",2);
    hold on;
end
axis([-1 ptt(n+i,1)+1 -0.55 0.55]);
legend('Kecepatan linier roda kiri Vl',' Kecepatan linier roda kanan Vr');