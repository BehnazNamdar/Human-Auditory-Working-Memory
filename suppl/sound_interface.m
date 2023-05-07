function   [ w , sample_rate] = sound_interface(style, sound_param , head )

% head is a name of the sound that is going to be played as below: 
                    %     'violation_sound' 
                    %     'error_sound' 
                    %     'timeout_sound'
                    %     'go_sound' 
                    %     'reward_sound' 
                    %     'S_one_sound' 
                    %     'S_two_sound' 




sample_rate = sound_param.sample_rate;

switch head
    case 'violation_sound'
        bal        = sound_param.violation_sound.Bal;
        dur1       = sound_param.violation_sound.Dur1 *1000;
        dur2       = sound_param.violation_sound.Dur2 *1000;
        freq1      = sound_param.violation_sound.Freq1;
        freq2      = sound_param.violation_sound.Freq2;
        tau        = sound_param.violation_sound.Tau *1000;
        gap        = sound_param.violation_sound.Gap *1000;
        fmfreq     = sound_param.violation_sound.FMFreq;
        fmamp      = sound_param.violation_sound.FMAmp;
        wnp        = sound_param.violation_sound.WNP;
        cntrst     = sound_param.violation_sound.Cntrst;
        cratio     = sound_param.violation_sound.CRatio;
        sigma      = sound_param.violation_sound.Sigma;
        freqs      = sound_param.violation_sound.FreqS;
        stereo_1st = sound_param.violation_sound.Stereo_1st;
        width      = sound_param.violation_sound.Width;
        collision  = sound_param.violation_sound.Collisions;
        forcecount = sound_param.violation_sound.ForceCount;
        RVol=sound_param.violation_sound.Vol * min(1,(1+bal));
        LVol=sound_param.violation_sound.Vol * min(1,(1-bal));
    case 'error_sound' 
        bal        = sound_param.error_sound.Bal;
        dur1       = sound_param.error_sound.Dur1 *1000;
        dur2       = sound_param.error_sound.Dur2 *1000;
        freq1      = sound_param.error_sound.Freq1;
        freq2      = sound_param.error_sound.Freq2;
        tau        = sound_param.error_sound.Tau *1000;
        gap        = sound_param.error_sound.Gap *1000;
        fmfreq     = sound_param.error_sound.FMFreq;
        fmamp      = sound_param.error_sound.FMAmp;
        wnp        = sound_param.error_sound.WNP;
        cntrst     = sound_param.error_sound.Cntrst;
        cratio     = sound_param.error_sound.CRatio;
        sigma      = sound_param.error_sound.Sigma;
        freqs      = sound_param.error_sound.FreqS;
        stereo_1st = sound_param.error_sound.Stereo_1st;
        width      = sound_param.error_sound.Width;
        collision  = sound_param.error_sound.Collisions;
        forcecount = sound_param.error_sound.ForceCount;
        RVol=sound_param.error_sound.Vol * min(1,(1+bal));
        LVol=sound_param.error_sound.Vol * min(1,(1-bal));
    case 'timeout_sound'
        bal        = sound_param.timeout_sound.Bal;
        dur1       = sound_param.timeout_sound.Dur1 *1000;
        dur2       = sound_param.timeout_sound.Dur2 *1000;
        freq1      = sound_param.timeout_sound.Freq1;
        freq2      = sound_param.timeout_sound.Freq2;
        tau        = sound_param.timeout_sound.Tau *1000;
        gap        = sound_param.timeout_sound.Gap *1000;
        fmfreq     = sound_param.timeout_sound.FMFreq;
        fmamp      = sound_param.timeout_sound.FMAmp;
        wnp        = sound_param.timeout_sound.WNP;
        cntrst     = sound_param.timeout_sound.Cntrst;
        cratio     = sound_param.timeout_sound.CRatio;
        sigma      = sound_param.timeout_sound.Sigma;
        freqs      = sound_param.timeout_sound.FreqS;
        stereo_1st = sound_param.timeout_sound.Stereo_1st;
        width      = sound_param.timeout_sound.Width;
        collision  = sound_param.timeout_sound.Collisions;
        forcecount = sound_param.timeout_sound.ForceCount;
        RVol=sound_param.timeout_sound.Vol * min(1,(1+bal));
        LVol=sound_param.timeout_sound.Vol * min(1,(1-bal));
    case 'go_sound' 
        
        bal        = sound_param.go_sound.Bal;
        dur1       = sound_param.go_sound.Dur1 *1000;
        dur2       = sound_param.go_sound.Dur2 *1000;
        freq1      = sound_param.go_sound.Freq1;
        freq2      = sound_param.go_sound.Freq2;
        tau        = sound_param.go_sound.Tau *1000;
        gap        = sound_param.go_sound.Gap *1000;
        fmfreq     = sound_param.go_sound.FMFreq;
        fmamp      = sound_param.go_sound.FMAmp;
        wnp        = sound_param.go_sound.WNP;
        cntrst     = sound_param.go_sound.Cntrst;
        cratio     = sound_param.go_sound.CRatio;
        sigma      = sound_param.go_sound.Sigma;
        freqs      = sound_param.go_sound.FreqS;
        stereo_1st = sound_param.go_sound.Stereo_1st;
        width      = sound_param.go_sound.Width;
        collision  = sound_param.go_sound.Collisions;
        forcecount = sound_param.go_sound.ForceCount;
        RVol=sound_param.go_sound.Vol * min(1,(1+bal));
        LVol=sound_param.go_sound.Vol * min(1,(1-bal));
        
    case 'reward_sound' 
        bal        = sound_param.reward_sound.Bal;
        dur1       = sound_param.reward_sound.Dur1 *1000;
        dur2       = sound_param.reward_sound.Dur2 *1000;
        freq1      = sound_param.reward_sound.Freq1;
        freq2      = sound_param.reward_sound.Freq2;
        tau        = sound_param.reward_sound.Tau *1000;
        gap        = sound_param.reward_sound.Gap *1000;
        fmfreq     = sound_param.reward_sound.FMFreq;
        fmamp      = sound_param.reward_sound.FMAmp;
        wnp        = sound_param.reward_sound.WNP;
        cntrst     = sound_param.reward_sound.Cntrst;
        cratio     = sound_param.reward_sound.CRatio;
        sigma      = sound_param.reward_sound.Sigma;
        freqs      = sound_param.reward_sound.FreqS;
        stereo_1st = sound_param.reward_sound.Stereo_1st;
        width      = sound_param.reward_sound.Width;
        collision  = sound_param.reward_sound.Collisions;
        forcecount = sound_param.reward_sound.ForceCount;
        RVol=sound_param.reward_sound.Vol * min(1,(1+bal));
        LVol=sound_param.reward_sound.Vol * min(1,(1-bal)); 
    case 'S_one_sound' 
        bal        = sound_param.S_one_sound.Bal;
        dur1       = sound_param.S_one_sound.Dur1 *1000;
        dur2       = sound_param.S_one_sound.Dur2 *1000;
        freq1      = sound_param.S_one_sound.Freq1;
        freq2      = sound_param.S_one_sound.Freq2;
        tau        = sound_param.S_one_sound.Tau *1000;
        gap        = sound_param.S_one_sound.Gap *1000;
        fmfreq     = sound_param.S_one_sound.FMFreq;
        fmamp      = sound_param.S_one_sound.FMAmp;
        wnp        = sound_param.S_one_sound.WNP;
        cntrst     = sound_param.S_one_sound.Cntrst;
        cratio     = sound_param.S_one_sound.CRatio;
        sigma      = sound_param.S_one_sound.Sigma;
        freqs      = sound_param.S_one_sound.FreqS;
        stereo_1st = sound_param.S_one_sound.Stereo_1st;
        width      = sound_param.S_one_sound.Width;
        collision  = sound_param.S_one_sound.Collisions;
        forcecount = sound_param.S_one_sound.ForceCount;
        RVol=sound_param.S_one_sound.Vol * min(1,(1+bal));
        LVol=sound_param.S_one_sound.Vol * min(1,(1-bal));
    case 'S_two_sound' 
        bal        = sound_param.S_two_sound.Bal;
        dur1       = sound_param.S_two_sound.Dur1 *1000;
        dur2       = sound_param.S_two_sound.Dur2 *1000;
        freq1      = sound_param.S_two_sound.Freq1;
        freq2      = sound_param.S_two_sound.Freq2;
        tau        = sound_param.S_two_sound.Tau *1000;
        gap        = sound_param.S_two_sound.Gap *1000;
        fmfreq     = sound_param.S_two_sound.FMFreq;
        fmamp      = sound_param.S_two_sound.FMAmp;
        wnp        = sound_param.S_two_sound.WNP;
        cntrst     = sound_param.S_two_sound.Cntrst;
        cratio     = sound_param.S_two_sound.CRatio;
        sigma      = sound_param.S_two_sound.Sigma;
        freqs      = sound_param.S_two_sound.FreqS;
        stereo_1st = sound_param.S_two_sound.Stereo_1st;
        width      = sound_param.S_two_sound.Width;
        collision  = sound_param.S_two_sound.Collisions;
        forcecount = sound_param.S_two_sound.ForceCount;
        RVol=sound_param.S_two_sound.Vol * min(1,(1+bal));
        LVol=sound_param.S_two_sound.Vol * min(1,(1-bal));
end
        
        



switch style %{'Tone','Bups','ToneSweep','BupsSweep','ToneFMWiggle',PClick','File'}
    case 'Tone'
        
        t=0:(1/sample_rate):(dur1/1000); t = t(1:end-1);
        tw=sin(t*2*pi*freq1);
        RW=RVol*tw;
        LW=LVol*tw;
        clear tw;
        %                     eval([sname,'Left_Click_Times.value  = 0;']);
        %                     eval([sname,'Right_Click_Times.value = 0;']);
    case 'Bups'
        tw=MakeBupperSwoop(sample_rate,0, freq1 , freq1 , dur1/2 , dur1/2,0,0.1);
        RW=RVol*tw;
        LW=LVol*tw;
        clear tw;
        %                     eval([sname,'Left_Click_Times.value  = 0;']);
        %                     eval([sname,'Right_Click_Times.value = 0;']);
    case 'ToneSweep',
        tw=MakeSigmoidSwoop3(sample_rate,0,freq1, freq2, dur1, dur2, gap, tau);
        RW=RVol*tw;
        LW=LVol*tw;
        clear tw;
        %                     eval([sname,'Left_Click_Times.value  = 0;']);
        %                     eval([sname,'Right_Click_Times.value = 0;']);
    case 'ToneFMWiggle',
        if (freq1-fmfreq)<0
            warning('SOUNDUI:ToneFMWiggle','Please make the FM freq less than carrier freq.');
            return;
        end
        if (freq1-fmamp)<=0
            warning('SOUNDUI:ToneFMWiggle','Please make the FMAmp less than carrier freq.');
            return;
        end
        tw=MakeFMWiggle(sample_rate,0, dur1/1000, freq1, fmfreq, fmamp);
        RW=RVol*tw;
        LW=LVol*tw;
        clear tw;
        
        
        %                     eval([sname,'Left_Click_Times.value  = 0;']);
        %                     eval([sname,'Right_Click_Times.value = 0;']);
    case 'AMTone',
        if (freq1-fmfreq)<0
            warning('SOUNDUI:AMTone','Please make the AM freq less than carrier freq.');
            return;
        end
        if  fmamp<0
            warning('SOUNDUI:AMTone','Please make the AM Amp greater than zero.');
            return;
        end
        params.carrier_frequency      = freq1;
        params.carrier_phase          = 0;
        params.modulation_frequency	= fmfreq;
        params.modulation_phase       = 0;
        params.modulation_depth       = fmamp;
        params.amplitude              = 80;
        params.duration               = dur1;
        if loop
            params.ramp                   = 0;
        else
            params.ramp=5;
        end
        tw=MakeAMTone(params, sample_rate);
        RW=RVol*tw;
        LW=LVol*tw;
        clear tw;
        
        %                     eval([sname,'Left_Click_Times.value  = 0;']);
        %                     eval([sname,'Right_Click_Times.value = 0;']);
        
    case 'BupsSweep',
        tw=MakeBupperSwoop(sample_rate,0,freq1, freq2, dur1, dur2, gap, tau);
        RW=RVol*tw;
        LW=LVol*tw;
        clear tw;
        
        %                     eval([sname,'Left_Click_Times.value  = 0;']);
        %                     eval([sname,'Right_Click_Times.value = 0;']);
        
    case 'WhiteNoise',
        t=0:(1/sample_rate):(dur1/1000); t = t(1:end-1);
        RW=RVol*randn(size(t));
        LW=LVol*randn(size(t));
        clear t;
        
        %                     eval([sname,'Left_Click_Times.value  = 0;']);
        %                     eval([sname,'Right_Click_Times.value = 0;']);
        
    case 'WhiteNoiseRamp',
        if dur1==0,
            RW = []; LW = [];
        else
            t=0:(1/sample_rate):(dur1/1000); t = t(1:end-1);
            if vol>0,
                vramp = vol*exp((t/t(end)).*log(vol2/vol));
            else
                vramp = vol + (t/t(end))*(vol2 - vol);
                warning('SOUNDUI:LogOfZero', 'WhiteNoiseRamp: vol==0, using linear instead of log volume scale');
            end;
            RW=vramp.*randn(size(t));
            LW=vramp.*randn(size(t));
            clear t; clear vramp;
        end;
        
        %                     eval([sname,'Left_Click_Times.value  = 0;']);
        %                     eval([sname,'Right_Click_Times.value = 0;']);
        
    case 'WhiteNoiseTone',
        t=0:(1/sample_rate):(dur1/1000); t = t(1:end-1);
        tw=sin(t*2*pi*freq1)+1;
        wn=rand(size(tw))*2;
        
        tw=tw*(1-wnp);
        wn=wn*wnp;
        tw=tw+wn;
        tw=tw-min(tw);
        tw=tw*(2/max(tw));
        tw=tw-1;
        
        RW=RVol*tw;
        LW=LVol*tw;
        clear tw;
        
        %                     eval([sname,'Left_Click_Times.value  = 0;']);
        %                     eval([sname,'Right_Click_Times.value = 0;']);
        
    case 'SpectrumNoise',
        tw = MakeSpectrumNoise(sample_rate, freq1, freq2, dur1, cntrst, cratio, 'stdev', sigma, 'baseline', 0.05);
        RW = RVol * tw;
        LW = LVol * tw;
        clear tw;
        %                     eval([sname,'Left_Click_Times.value  = 0;']);
        %                     eval([sname,'Right_Click_Times.value = 0;']);
    case 'PClick',
        [SW lrate rrate data] = make_pbup(freq1 + freq2, log(freq2 / freq1), sample_rate, dur1/1e3,...
            'bup_width', width, 'first_bup_stereo', stereo_1st, 'distractor_rate', freqs,...
            'avoid_collisions',~collision, 'force_count',forcecount); %#ok<NASGU>
        LW = SW(1,:) * LVol;
        RW = SW(2,:) * RVol;
        %                     eval([sname,'Left_Click_Times.value  = data.left;']);
        %                     eval([sname,'Right_Click_Times.value = data.right;']);
        
    case 'File',
        % warning('Plugins:SoundInterface:SoundFilesNotDone','Loading sounds from files not implemented yet');
        [LW, RW]=getWavefromFile(value(eval([sname 'SndsMenu'])), sample_rate, LVol, RVol);
        
        
    otherwise
        warning('Plugins:SoundInterface:UnknownStyle','Unknown style %s',style);
        
end
w=[LW;RW];
end

