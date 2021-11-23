function [step,M1,M2,k1,k2,k3,c1,c2,c3,x1_0,x2_0,v1_0,v2_0]=data_input()
    prompt={'time multiplier','M1','M2','k1','k2','k3','c1','c2','c3','x1_0','x2_0','v1_0','v2_0'};
    title='Parametri Simulazione';
    lines=1;
    def={'1','5','5','50','50','85','3','3','3','18','-5','10','26'};
    answer=inputdlg(prompt,title,lines,def,'on');
    if isempty(answer)
        return
    end
    step = str2num(char(answer(1)))
    M1=str2num(char(answer(2)));
    M2=str2num(char(answer(3)));
    k1=str2num(char(answer(4)));
    k2=str2num(char(answer(5)));
    k3=str2num(char(answer(6)));
    c1=str2num(char(answer(7)));
    c2=str2num(char(answer(8)));
    c3=str2num(char(answer(9)));
    x1_0=str2num(char(answer(10)));
    x2_0=str2num(char(answer(11)));
    v1_0=str2num(char(answer(12)));
    v2_0=str2num(char(answer(13)));
