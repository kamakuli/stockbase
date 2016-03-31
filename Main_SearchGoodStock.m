%% Main_SearchGoodStock.m
%% set stock code
    StockC = '002751';
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
%%        
        %calculate 5 average
        n = 5;
        Len = length(StockData(:,5));
        s = CalculateStockAverage(StockData(:,5), n);
        %plot(s);
%%     ÕÒÉÏÉýÖÜÆÚ
        start = n+1;
        l1 = 0;
        sum = 0;
        for i=n+1:Len,
            if( s(i) > s(i-1) )
                l1 = l1+1;
            else
                if( (l1 > 25) )
                    disp(['find a up timezone, start at:',num2str(StockData(i-l1,1)),'      end at:',num2str(StockData(i,1)), '   last ',num2str(l1),' days']);                    
                    start = i;
                    l1 = 0;
                    sum = sum + 1;
                end
            end
        end
        disp(['There are ', num2str(sum), ' up cycles']);
        