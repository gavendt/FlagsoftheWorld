% ------------------------------------------------------------------------
% Name: Gabrielle Avendt
% Section: 02
% Submission Date: 12/10/23
%
% File Description: [ Tests user on flags of the world and allows user to study flags.]
%
%
% Citation: [Include any and all links of online resources that you
% utilized within your file. Provide line numbers of where the code
% can be found within your file. If a person aided you with your code,
% provide their full name and line numbers of what you were aided with
% it. Example shown below
%
% Resources | Line Number
% Professor Lucas | 68-69/88-92
%
%
% Rubirc score markers: [Provide a list of all score markers covered
% within this file., including the line number. Example shown below
% Score Marker | Line Number
% %<SM:IF:AVENDT> | 20
%
% Note that you are still expected to insert the score markers within
% your code as well.]
%
%
% CORE TECHNIQUES:
%
% <SM:ROP:AVENDT> 68
% <SM:BOP:AVENDT> 68
% <SM:IF:AVENDT> 80
% <SM:SWITCH:AVENDT> N/A (If statements instead)
% <SM:FOR:AVENDT> 88
% <SM:WHILE:AVENDT> 63
% <SM:RANDOM:AVENDT> 91
% <SM:PDF:AVENDT> 240
% <SM:PDF_PARAM:AVENDT> 181
% <SM:PDF_RETURN:AVENDT> 181
% <SM:READ:AVENDT> 73
% <SM:WRITE:LASTNAME> N/A

% SPECIFIC TECHNIQUES:
% <SM:STRING:AVENDT> 67
% <SM:REF:AVENDT> N/A
% <SM:SLICE:AVENDT> # in Flags of the World_xlsx: 93
% <SM:AUG:AVENDT> N/A
% <SM:DIM:AVENDT> 174
% <SM:SORT:AVENDT> N/A
% <SM:SEARCH:AVENDT> N/A
% <SM:FILTER:AVENDT> 194-198
% <SM:VIEW:AVENDT> 97
% <SM:PLOT:LASTNAME> 149
%

% -------------------------------------------------------------------------

clear
clc
close all

RunAgain = 'yes';
while strcmpi(RunAgain, 'yes') == 1 % <SM:WHILE:AVENDT> SM:ROP:AVENDT % 

    %Intro
    fprintf('Welcome to Flag Guesser. You can be tested on the flags of the world or you can study.\n')
    GameMode = input('Would you like to be tested on flags of the world or study (type Test or Study)?: ', 's'); %<SM:STRING:AVENDT>
    while isempty(GameMode) || strcmpi(GameMode, 'Test') == 0 && strcmpi(GameMode, 'Study') == 0 % <SM:ROP:AVENDT> % <SM:WHILE:AVENDT> <SM:BOP:AVENDT>
        GameMode = input('ERROR. Would you like to be tested on flags of the world or study (type Test or Study)?: ', 's');
    end

    %Inports data from excel
    data = readcell('Flags of the World.xlsx'); % <SM:READ:AVENDT> 
    countries = data(2:end,1);

    [NumRow, NumCol] = size(data);


    %Mode: test, sets # of rounds
    if strcmpi(GameMode,'Test') == 1 % <SM:IF:AVENDT> 
        Rounds = input('How many rounds would you like to play? (1-10): ');
        while isempty(Rounds) || Rounds < 1 || Rounds > 10 || mod(Rounds, 1) ~= 0 % <SM:ROP:AVENDT> % <SM:BOP:AVENDT> % <SM:WHILE:AVENDT>
            Rounds = input('ERROR. How many rounds would you like to play? (1-10): ');
        end

        Score = 0;

        for k=1:Rounds %<SM:FOR:AVENDT> 

            % Randomely selects flag and shows picture of it
            FlagSelection = round(rand*(NumRow-2)+2); % <SM:RANDOM:AVENDT>

            CountryName = data{FlagSelection,1}; % <SM:SLICE:AVENDT>

            ImageName = sprintf('%sFlag.jpg', CountryName); 

            imshow(ImageName) % <SM:FILTER:AVENDT>
            % User inputs their answer
            Attempt = input('What country does the flag just shown represent?: ', 's'); %<SM:STRING:AVENDT>
            Rematch = 1;
            RematchCounter = 0;
            ScoreCounter = 0;

            %Error specific messages
            while (isempty(Attempt) || strcmpi(Attempt,CountryName) == 0 || ismember(lower(Attempt),lower(countries)) == 0)  && strcmpi(Rematch, 'give up') == 0 %<SM:ROP:AVENDT> % <SM:BOP:AVENDT> % <SM:WHILE:AVENDT>  %ERROR CHECKING- gives specific message to error
                if isempty(Attempt) % <SM:IF:AVENDT>
                    Attempt = input('ERROR. Enter what country the flag just shown represents?: ', 's'); %<SM:STRING:AVENDT>

                elseif ismember(lower(Attempt),lower(countries)) == 0
                    Attempt = input('ERROR. That country is not included in this game. Check your spelling and try again: ', 's'); %<SM:STRING:AVENDT>

                elseif strcmpi(Attempt,CountryName) == 0 % <SM:ROP:AVENDT> 
                    Rematch = input('Incorrect. Try again or give up? (Type try again or give up): ', 's'); %<SM:STRING:AVENDT>
                    while isempty(Rematch) || strcmpi(Rematch, 'try again') == 0 && strcmpi(Rematch, 'give up') == 0 % <SM:ROP:AVENDT> % <SM:BOP:AVENDT> % <SM:WHILE:AVENDT> 
                        Rematch = input('Error. Type try again or give up: ', 's'); %<SM:STRING:AVENDT>
                    end

                    if strcmpi(Rematch,'try again') == 1 % <SM:ROP:AVENDT> 
                        Attempt = input('Rematch: what country does the flag just shown represent?: ', 's'); %<SM:STRING:AVENDT>
                        RematchCounter = RematchCounter +1;
                    end

                end
            end

            % Message if attempt is correct
            if strcmpi(Attempt,CountryName) == 1  % <SM:ROP:AVENDT> % <SM:IF:AVENDT> 
                fprintf('Correct.\n')
                fprintf('You needed to retry this flag %d time(s).\n\n', RematchCounter)
                Score = Score + 1;


                %Message if give up
            else
                fprintf('The country shown was %s. \n', CountryName);
            end
            close all

        end

        fprintf('Your total score was %d / %d', Score, Rounds)

        %Pie Chart - displays % correct and incorrect
        PercentageCorrect = Score /Rounds;
        PercentageWrong = 1 - PercentageCorrect;
        PieChart = [PercentageWrong, PercentageCorrect];
        Label = {'Incorrect', 'Correct'};

        pie(PieChart,Label) % <SM:PLOT:LASTNAME>
        colormap("prism")
        title('Pie Chart of Correct and Incorrect Answers')


        %Study mode
    elseif strcmpi(GameMode, 'Study') == 1 % <SM:ROP:AVENDT> 
        fprintf('Welcome to study mode. You will be able to study flags by color, shape, and crest. \n')
        StudyMode = input('Which mode would you like to study in? Type color, shape, or crest: ', 's'); %<SM:STRING:AVENDT>
        Modes = {'Color', 'Shape', 'Crest', 'color', 'shape', 'crest'};
        while isempty(StudyMode) || ismember(StudyMode, Modes) == 0 % <SM:ROP:AVENDT> % <SM:BOP:AVENDT> % <SM:WHILE:AVENDT>
            StudyMode = input('Error. Type color, shape, or crest: ', 's'); %<SM:STRING:AVENDT>
        end

        %Study by color
        if strcmpi(StudyMode, 'Color') == 1 % <SM:ROP:AVENDT> % <SM:IF:AVENDT> 
            ColorInput = input('What color would you like to study? (Type blue, green, yellow, white, red, orange, black): ' , 's'); %<SM:STRING:AVENDT>
            Colors = {'Blue', 'Green', 'Yellow', 'White', 'Red', 'Orange', 'Black'};

            while isempty(ColorInput) || ismember(lower(ColorInput), lower(Colors)) == 0 % <SM:ROP:AVENDT> % <SM:BOP:AVENDT> % <SM:WHILE:AVENDT>
                ColorInput = input('Error. Type blue, green, yellow, white, red, orange, black: ' , 's'); %<SM:STRING:AVENDT>
            end

            CountriesWithColor = [];
            
            for k=2:NumRow % <SM:DIM:AVENDT> %<SM:FILTER:AVENDT> %<SM:FOR:AVENDT>
                if strcmpi(ColorInput,data{k,(2)}) || strcmpi(ColorInput, data{k,(3)}) || strcmpi(ColorInput, data{k,(4)}) % <SM:IF:AVENDT> <SM:BOP:AVENDT> 
                    CountriesWithColor = [CountriesWithColor; data(k,:)];
                end
            end
            fprintf('The flags that have %s in them are:\n', ColorInput)

            CountriesWithColorNamesTable = FeatureSlice(CountriesWithColor); %<SM:PDF:AVENDT> 


            %Study by shape
        elseif strcmpi(StudyMode, 'Shape') == 1
            ShapeInput = input('What shape do you want to study? (Type horizontal lines, vertical lines, stars, triangles, or circles): ', 's'); %<SM:STRING:AVENDT>
            Shapes = {'Horizontal lines', 'Vertical lines', 'Stars', 'Triangles', 'Circles'};
            while isempty(ShapeInput) || ismember(lower(ShapeInput), lower(Shapes)) == 0 % <SM:ROP:AVENDT> % <SM:BOP:AVENDT> % <SM:WHILE:AVENDT>
                ShapeInput = input('Error. Type horizontal lines, vertical lines, stars, triangles, or circles: ', 's'); %<SM:STRING:AVENDT>
            end

            CountriesWithShape = [];

            for k=2:NumRow % <SM:DIM:AVENDT> %  % <SM:FILTER:AVENDT> %<SM:FOR:AVENDT>
                if strcmpi(ShapeInput,data{k,(5)}) || strcmpi(ShapeInput, data{k,(6)}) %<SM:BOP:AVENDT>
                    CountriesWithShape = [CountriesWithShape; data(k,:)];
                end
            end
            fprintf('The flags that have %s in them are:\n', ShapeInput)

            CountriesWithShapeNamesTable = FeatureSlice(CountriesWithShape);% <SM:PDF:AVENDT> 


            %Study by crest
        elseif strcmpi(StudyMode, 'Crest') == 1 % <SM:ROP:AVENDT>
            fprintf('In this code, a crest is a symbol that cannot be classified as a shape.\n')
            CrestInput = input('Would you like to study flags with or without crests? (Type with or without): ', 's'); %<SM:STRING:AVENDT>
            Crests = {'With', 'Without'};
            while isempty(CrestInput) || ismember(lower(CrestInput), lower(Crests)) == 0 % <SM:ROP:AVENDT> % <SM:BOP:AVENDT> % <SM:WHILE:AVENDT>
                CrestInput = input('Error. Type with or without: ', 's'); %<SM:STRING:AVENDT>
            end

            CountriesWithCrest = [];

            for k=2:NumRow % <SM:DIM:AVENDT> %  % <SM:FILTER:AVENDT> %<SM:FOR:AVENDT>
                if strcmpi(CrestInput,data{k,(7)})
                    CountriesWithCrest = [CountriesWithCrest; data(k,:)];
                end
            end

            fprintf('The flags %s a crest are:\n', CrestInput)

            CountriesWithCrestNamesTable = FeatureSlice(CountriesWithCrest); % <SM:PDF:AVENDT> 



        end
    end

    %Run Code again
    RunAgain = input('\nWould you like to run the code again (Type yes or no): ', 's'); %<SM:STRING:AVENDT>
    while isempty(RunAgain) ||   strcmpi(RunAgain, 'yes') == 0 && strcmpi(RunAgain, 'no') == 0 %<SM:BOP:AVENDT> %<SM:WHILE:AVENDT> 
        RunAgain = input('ERROR. Type yes or no: ', 's'); %<SM:STRING:AVENDT>
    end
end


%% Functions

function CountriesWithFeatureNamesTable = FeatureSlice(CountriesWithFeature) % <SM:PDF:AVENDT> 
%CountriesWithFeatureNamesTable = FeatureSlice(CountriesWithFeature)
%   This function creates a table of the countries with chosen feature,
%   then allows users to show item on the table

close all

CountriesWithFeatureNames = [CountriesWithFeature(:,1)]; % <SM:FILTER:AVENDT>

CountryName = char(CountriesWithFeature(:,1));


title_labels = {'Countries with chosen feature'};

CountriesWithFeatureNamesTable = table(CountryName, 'VariableNames',title_labels);
disp(CountriesWithFeatureNamesTable)

RunAgainColor = 'yes';


%Run Again
while strcmpi(RunAgainColor, 'yes') == 1 %<SM:WHILE:AVENDT> 

    DisplayFlag = input('Type a countrys name to show its flag: ', 's'); %<SM:STRING:AVENDT>
    while isempty(DisplayFlag) || ismember(lower(DisplayFlag), lower(CountriesWithFeatureNames)) == 0 % <SM:ROP:AVENDT> % <SM:BOP:AVENDT> % <SM:WHILE:AVENDT>
        DisplayFlag = input('ERROR. Type a countrys name (shown above) to show its flag: ', 's'); %<SM:STRING:AVENDT>
    end

    DisplayFlagJPG = sprintf('%sFlag.jpg', DisplayFlag);
    imshow(DisplayFlagJPG)
     
    RunAgainColor = input('Would you like to display another flag (Type yes or no): ', 's'); %<SM:STRING:AVENDT>
    while isempty(RunAgainColor) ||   strcmpi(RunAgainColor, 'yes') == 0 && strcmpi(RunAgainColor, 'no') == 0 %<SM:BOP:AVENDT> <SM:WHILE:AVENDT> 
        RunAgainColor = input('ERROR. Type yes or no: ', 's'); %<SM:STRING:AVENDT>
    end

    close all

end
end

