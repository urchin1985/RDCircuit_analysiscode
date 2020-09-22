Data_F3.B.ca_activity = cdata;
Data_F3.B.neuron_id_per_colume = cnmvec;
Data_F3.B.state = btdata;
Data_F3.B.axial_velocity = vdata;
Data_F3.B.time_sec = catime;

%%
Data_F3.C.tph1pdfr1.NSM_activity = cdata(:,1);
Data_F3.C.tph1pdfr1.AVB_activity = cdata(:,4);
Data_F3.C.tph1pdfr1.speed = abs(vdata);

%%
Data_F4.C.example3.ca_activity = cdata;
Data_F4.C.example3.neuron_id_per_colume = cnmvec;
Data_F4.C.example3.state = btdata;
Data_F4.C.example3.axial_velocity = vdata;
Data_F4.C.example3.time_sec = catime;

%%
 ki = find(oppre>pth);
    ozmat = opmat(ki,:);
Data_F5.A.pdfr1.roaming_animal_speed_response = ozmat;
   ki = find(oppre<pth);
    ozmat = opmat(ki,:);
Data_F5.A.pdfr1.dwelling_animal_speed_response = ozmat;
Data_F5.A.pdfr1.time_to_stim_onset = -10+(0:240)*.33;
Data_F5.A.pdfr1.data_dimensions = ['stimulus epoch','time'];
%%
Data_F6.G.AIAsilenced_highdensity.fraction_roaming = xft;
Data_F6.G.AIAsilenced_highdensity.roaming_duration = rdurs;
Data_F6.G.AIAsilenced_highdensity.dwelling_duration = ddurs;
%%
save([savpath 'RD manuscript data.mat'],'Data_F1_S4','-append')
save([savpath 'RD manuscript data-copy.mat'],'Data_F1_S4','-append')