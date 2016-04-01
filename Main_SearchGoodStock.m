%% Main_SearchGoodStock.m
    clear;
%% set stock code
    StockC = '600016';
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
        n = 60;
        n1 = 30;
        
        ss = StockData(:,5);
        Len = length(ss);
        s = CalculateStockAverage(ss, n);
        
        s1 = CalculateStockAverage(ss, n1);
        %plot(s);
%%     find long periods for rising or falling
        cycle = 20;

        start = n+1;
        l1 = 0;
        sum = 0;
        up = zeros(Len,1);
        
        start2 = n+1;
        l2 = 0;
        sum2 = 0;
        down = zeros(Len,1);
        for i=n+1:Len,
            if( (s(i) > s(i-1) ) && (s1(i) > s1(i-1)) ) 
                l1 = l1+1;
            else                
                if( (l1 > cycle) )
                    gain = s(i)/s(i-l1); % we shall compare this to index gain (the stock belongs to which stock plate)
                    g1 = ss(i)/ss(i-l1);
                    if( g1 > 1.2 )
                        disp(['find a up timezone[i=',num2str(i),'], start at:',num2str(StockData(i-l1,1)),'      end at:',num2str(StockData(i,1)), '   last ',num2str(l1),' days', '  from  ', num2str(s(i-l1)), ' to ', num2str(s(i)), '     gain %', num2str(g1*100-100)]);
                        sum = sum + 1;
                        up(i-l1)=ss(i-l1);
                        up(i) = ss(i);
                    end
                end
                start = i;  
                l1 = 0;
            end
            
%             if( (s(i) < s(i-1) ) ) % || (s(i)/s(start2) > 1.3
%                 l2 = l2+1;
%             else                
%                 if( (l2 > cycle) )
%                     gain = s(i)/s(i-l2); % we shall compare this to index gain (the stock belongs to which stock plate)
%                     if( gain < 0.85)
%                         disp(['====find a down timezone[i=',num2str(i),'], start at:',num2str(StockData(i-l2,1)),'      end at:',num2str(StockData(i,1)), '   last ',num2str(l2),' days', '  from  ', num2str(s(i-l2)), ' to ', num2str(s(i)), '     gain %', num2str(gain*100-100)]);
%                         sum2 = sum2 + 1;
%                         down(i-l2)=ss(i-l2);
%                         down(i) = ss(i);
%                     end
%                 end
%                 start2 = i;  
%                 l2 = 0;
%             end
        end
        disp(['There are ', num2str(sum), ' long rising cycles & ',num2str(sum2),' long falling cycles']);
        plot(s, 'y')
        hold on
        plot(ss,'k')
        hold on
        plot(up,'r')
%         hold on        
%         plot(down,'g')
        q7 = StockData(:,7);
        max7 = max(q7);
        q7 = q7/max7*max(s)/2;
        hold on
        bar(q7,'b')
        