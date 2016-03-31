%% Main_SearchGoodStock.m
%% set stock code
    StockC = '002751'
    StockIndex = str2num(StockC);
%% load list
        %load StockList.mat
        %Len = size(StockList, 1);
        %StockCode = StockList(:,2);
        %StockName = StockList(:,1);
%% find the mat file      
        %FolderStrD_Ex = ['./DataBase/Stock/Day_ExDividend_mat'];
        FolderStr = ['./DataBase/Stock/Day_ForwardAdj_mat'];
        if ~isdir( FolderStr )
            disp('directory does not exist')
            return;
        end

        prefix = '';
        
        if( StockIndex >= 600000 ) && ( StockIndex < 605000)
            prefix = 'sh';
        end
        
        if( StockIndex > 000000 ) && ( StockIndex < 003000)
            prefix = 'sz';
        end
        
        if( StockIndex > 300000 ) && ( StockIndex < 301000)
            prefix = 'sz';
        end          


        %Scode = StockCode{i};
        %Sname = StockName{i};
       
        %FileStringD_Ex = [FolderStrD_Ex,'/',StockCode{i},'_D_ExDiv.mat'];
        FileString = [FolderStr,'/',prefix,StockC,'_D_ForwardAdj.mat'];
%% load mat file
        str = ['load ',FileString];
        eval(str);
%%
        %disp(str)
        str=['start data: ',num2str(StockData(1,1))];
        disp(str);
        str=['end data  : ',num2str(StockData(end,1))];
        disp(str);     
        s = StockData(:,5);