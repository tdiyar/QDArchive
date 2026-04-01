* Encoding: UTF-8.
* Change working directory (Please change to your working directory).
CD 'C:\Users\alexs\Documents\Sync\UniCloud\Gewichtung VIC\Datenmanagement VIC-Studie'.

* Load data.
GET FILE='Werte in der Krise_Datensatz AT_aufbereitet.sav'.
DATASET NAME VIC.
DATASET ACTIVATE VIC.

*****************************************

* 1. Fix system missings

*****************************************

RECODE Q53A1 TO Q53A4 (MISSING=9) (ELSE=COPY).

*****************************************
 
* 2. Build Schwartz Value Scale (SVS) according to
* http://essedunet.nsd.uib.no/cms/topics/1/4/1.html

* 2.1. Revert variable coding, provide labels and define missings.

*****************************************

RECODE
        SVSA1 SVSA2 SVSA3 
        SVSA4 SVSA5 SVSA6 
        SVSA7 SVSA8 SVSA9 
        SVSA10 SVSA11 SVSA12 
        SVSA13 SVSA14 SVSA15 
        SVSA16 SVSA17 SVSA18 
        SVSA19 SVSA20 SVSA21 SVSA22 
        (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (7=7) (8=8) (9=9)
    INTO nSVSA1 nSVSA2 nSVSA3 
        nSVSA4 nSVSA5 nSVSA6 
        nSVSA7 nSVSA8 nSVSA9 
        nSVSA10 nSVSA11 nSVSA12 
        nSVSA13 nSVSA14 nSVSA15 
        nSVSA16 nSVSA17 nSVSA18 
        nSVSA19 nSVSA20 nSVSA21 nSVSA22.
FORMATS nSVSA1 TO nSVSA22 (f1.0).
VARIABLE LABELS
    nSVSA1 'Important to think new ideas and being creative'
    nSVSA2 'Important to be rich, have money and expensive things'
    nSVSA3 'Important that people are treated equally and have equal opportunities'
    nSVSA4 'Important to show abilities and be admired'
    nSVSA5 'Important to live in secure and safe surroundings'
    nSVSA6 'Important to try new and dIFferent things in lIFe'
    nSVSA7 'Important to do what is told and follow rules'
    nSVSA8 'Important to understand dIFferent people'
    nSVSA9 'Important to be humble and modest, not draw attention'
    nSVSA10 'Important to have a good time'
    nSVSA11 'Important to make own decisions and be free'
    nSVSA12 'Important to help people and care for others well-being'
    nSVSA13 'Important to be successful and that people recognize achievements'
    nSVSA14 'Important that government is strong and ensures safety'
    nSVSA15 'Important to seek adventures and have an exiting lIFe'
    nSVSA16 'Important to behave properly'
    nSVSA17 'Important to get respect from others'
    nSVSA18 'Important to be loyal to friends and devote to people close'
    nSVSA19 'Important to care for nature and environment'
    nSVSA20 'Important to follow traditions and customs'
    nSVSA21 'Important to help people and do good for the community'
    nSVSA22 'Important to seek fun and things that give'.
VALUE LABELS nSVSA1 to nSVSA22 
    1 "Not like me at all" 
    2 "Not like me" 
    3 "A little like me" 
    4 "Somewhat like me" 
    5 "Like me" 
    6 "Very much like me"
    7 "Refusal" 
    8 "Don't know" 
    9 "No answer".
Missing values nSVSA1 to nSVSA22 (7 to 9).
EXECUTE.

*****************************************
 
* 2.2. Build mean raw rating for ten values.
* Indicate in the label or the name, that this is the  mean raw rating.

*****************************************

COMPUTE Apow = MEAN (nSVSA2, nSVSA17).
COMPUTE Aach = MEAN (nSVSA4, nSVSA13).
COMPUTE Ahed = MEAN (nSVSA22, nSVSA10).
COMPUTE Asti = MEAN (nSVSA6, nSVSA15).
COMPUTE Aself = MEAN (nSVSA1, nSVSA11).
COMPUTE Auni = MEAN (nSVSA3, nSVSA8, nSVSA19).
COMPUTE Aben = MEAN (nSVSA12, nSVSA18).
COMPUTE Atra = MEAN (nSVSA9, nSVSA20).
COMPUTE Acon = MEAN (nSVSA16, nSVSA7).
COMPUTE Asec = MEAN (nSVSA5, nSVSA14).
EXECUTE.
VARIABLE LABELS
    APow 'Power – mean of raw rating'
    Aach 'Achievement – mean of raw rating'
    Ahed 'Hedonism – mean of raw rating'
    Asti 'Stimulation – mean of raw rating'
    Aself 'Self-Direction – mean of raw rating'
    Auni 'Universalism – mean of raw rating'
    ABen 'Benevolence – mean of raw rating'
    Atra 'Tradition – mean of raw rating'
    ACon 'Conformity – mean of raw rating'
    ASec 'Security – mean of raw rating'.
EXECUTE.

*****************************************
 
* 2.3. COMPUTE each individual’s mean score on all 21 value-items 
* Call this variable MRAT.

*****************************************

COMPUTE MRAT = Mean (nSVSA1, nSVSA2, nSVSA3, 
                                        nSVSA4, nSVSA5, nSVSA6, 
                                        nSVSA7, nSVSA8, nSVSA9, 
                                        nSVSA10, nSVSA11, nSVSA12, 
                                        nSVSA13, nSVSA14, nSVSA15, 
                                        nSVSA16, nSVSA17, nSVSA18, 
                                        nSVSA19, nSVSA20, nSVSA22).
VARIABLE LABELS MRAT 'Mean score on all answered value items'.
EXECUTE.

*****************************************
 
* 2.4. Centre scores of each of the 10 values for an individual around that individual’s MRAT 
* Use the ten values COMPUTEd above, and subtract MRAT from each value
* Indicate in the label or the name, that this is the centred value score
* Centre scores of each of the ten values for an individual around that individual’s MRAT 
* Use the indexes COMPUTEd above and subtract MRAT.

*****************************************

COMPUTE Cpow = Apow - MRAT.
COMPUTE Cach = Aach - MRAT.
COMPUTE Ched = Ahed - MRAT.
COMPUTE Csti = Asti - MRAT.
COMPUTE Cself = Aself - MRAT.
COMPUTE Cuni = Auni - MRAT.
COMPUTE Cben = Aben - MRAT.
COMPUTE Ctra = Atra - MRAT.
COMPUTE Ccon = Acon - MRAT.
COMPUTE Csec = Asec - MRAT.
EXECUTE.
VARIABLE LABELS
    CPow 'Power - Centred value score'
    Cach 'Achievement - Centred value score'
    Ched 'Hedonism - Centred value score'
    Csti 'Stimulation - Centred value score'
    Cself 'Self-Direction - Centred value score'
    Cuni 'Universalism - Centred value score'
    CBen 'Benevolence - Centred value score'
    Ctra 'Tradition - Centred value score'
    CCon 'Conformity - Centred value score'
    CSec 'Security - Centred value score'.
EXECUTE.

*****************************************
 
* 2.5. COMPUTE higher-order values, hedonism is put together with openness
* Logical maximum = 6, max is obtained when a respondent has answered 6 
* on all the items indexing the HO value
* Logical minimum = 1, min is obtained when a respondent has answered 1 
* on all items indexing the HO value
* Create higher-order values.

*****************************************

COMPUTE OTC = Mean(nSVSA6, nSVSA15, nSVSA1, 
                                    nSVSA11, nSVSA22, nSVSA10).
COMPUTE CON = Mean(nSVSA9, nSVSA20, nSVSA16, 
                                    nSVSA7, nSVSA5, nSVSA14).
COMPUTE Self_tr = Mean(nSVSA12, nSVSA18, nSVSA3, 
                                      nSVSA8, nSVSA19).
COMPUTE Self_en = Mean(nSVSA2, nSVSA17, 
                                       nSVSA4, nSVSA13).
EXECUTE.
VARIABLE LABELS
    OTC 'Openness to change'
    CON 'Conservation'
    Self_tr 'Self-transcendence'
    Self_en 'Self-enhancement'.
EXECUTE.

*****************************************
 
* 2.6. COMPUTE higher-order values based on centered scales.

*****************************************

COMPUTE selfenhancement_c=(Cpow + Cach) / 2.
EXECUTE.
COMPUTE selftrancendence_c=(Cuni + Cben) / 2.
EXECUTE.
COMPUTE openness_c=(Csti + Ched + Cself) / 3.
EXECUTE.
COMPUTE conservation_c=(Ctra + Ccon + Csec) / 3.
EXECUTE.


*****************************************

* 3. drop all temporary files, resort and store dataset.

*****************************************

ADD FILES file *
/keep U0 TO weight
        Apow TO conservation_c.
EXECUTE.


*****************************************

* 4. store German dataset

*****************************************

SAVE OUTFILE='Values in Crisis Survey Austria_data German v02.sav'
  /COMPRESSED.



*****************************************
 
* 5. Translate German to English dataset.

* 5.1. Define English variable labels

*****************************************

VARIABLE LABELS
    U0 'Identifier'
    Q1 'Gender' 
    Q3A1 'Year of birth'
    Q7 'Marital status'
    Q8A1 'Number of children'
    VIC05 'highest educational level '
    Q11 'household’s net income '
    Q9A1 'Number of people living in household permanently'
    Q5 'Which phrase describes the area where you live?'
    Q4 'Region'
    Q18A1 'I have been tested positively for COVID-19.'
    Q18A2 'I have been tested negatively for COVID-19.'
    Q18A3 'I have or had mild symptoms of COVID-19.'
    Q18A4 'I have or had severe symptoms of COVID-19.'
    Q18A5 'People close to me have or had mild symptoms.'
    Q18A6 'People close to me have or had severe symptoms.'
    Q19A1 'I lost my job.'
    Q19A2 'I had to close my business.'
    Q19A3 'I am reduced to part time work.'
    Q19A4 'I am doing home office.'
    Q19A5 'I receive money from an aid package.'
    Q19A6 'I go to work as before.'
    Q19A7 'I daycare my kids.'
    Q20 'How afraid are you that you or your loved ones get sick and suffer severely from the Corona virus?'
    Q21 'How afraid are you that you or your loved ones will suffer from an economic recession following the Corona crisis?'
    Q22 'How well do you think our government is handling the Corona crisis?'
    Q23 'How properly do you think most people in our country are behaving under the imprint of the Corona crisis?'
    Q24 'Considering your encounters with other people these days, do you experience more solidarity than usual, or is it more hostility:'
    Q25 'Do you think our country will get out of this crisis severely hurt or greatly strengthened?'
    Q28A1 'Feeling nervous, anxious or on edge.'
    Q28A2 'Not being able to stop or control worrying.'
    Q28A3 'Feeling down, depressed or hopeless'
    Q28A4 'Little interest or pleasure in doing things.'
    Q28A5 'I have felt lonely.'
    Q31 'The social media are full of stories telling that the Corona pandemic is a hoax and that all the lockdown measures are a hysteric overreaction. Do you believe in these stories?'
    Q32 'How credible do you think are the social media, like Twitter and Facebook, compared to the traditional media, like TV and newspapers, using this scale:'
    SVSA1 'Thinking up new ideas and being creative is important to her/him. She/he likes to do things in her/his own original way.'
    SVSA2 'It is important to her/him to be rich. She/he wants to have a lot of money and expensive things.'
    SVSA3 'She/he thinks it is important that every person in the world should be treated equally. She/he believes everyone should have equal opportunities in life.'
    SVSA4 "It's important to her/him to show her/his abilities. She/he wants people to admire what she/he does."
    SVSA5 'It is important to her/him to live in secure surroundings. She/he avoids anything that might endanger her/his safety.'
    SVSA6 'She/he likes surprises and is always looking for new things to do. She/he thinks it is important to do lots of different things in life.'
    SVSA7 "She/he believes that people should do what they're told. She/he thinks people should follow rules at all times, even when no-one is watching."
    SVSA8 'It is important to her/him to listen to people who are different from her/him. Even when she/he disagrees with them, she/he still wants to understand them.'
    SVSA9 'It is important to her/him to be humble and modest. She/he tries not to draw attention to herself/himself.'
    SVSA10 "Having a good time is important to her/him. She/he likes to 'spoil' herself/himself."
    SVSA11 'It is important to her/him to make her/his own decisions about what she/he does. She/he likes to be free and not depend on others.'
    SVSA12 "It's very important to her/him to help the people around her/him. She/he wants to care for their well-being."
    SVSA13 'Being very successful is important to her/him. She/he hopes people will recognize her/his achievements.'
    SVSA14 'It is important to her/him that the government ensures her/his safety against all threats. She/he wants the state to be strong so it can defend its citizens.'
    SVSA15 'She/he looks for adventures and likes to take risks. She/he wants to have an exciting life.'
    SVSA16 'It is important to her/him always to behave properly. She/he wants to avoid doing anything people would say is wrong.'
    SVSA17 'It is important to her/him to get respect from others. She/he wants people to do what she/he says.'
    SVSA18 'It is important to her/him to be loyal to her/his friends. She/he wants to devote herself/himself to people close to her/him.'
    SVSA19 'She/he strongly believes that people should care for nature. Looking after the environment is important to her/him.' 
    SVSA20 'Tradition is important to her/him. She/he tries to follow the customs handed down by her/his religion or her/his family.'
    SVSA21 "It's very important to her/him to help other people and do good for the society at large."
    SVSA22 'She/he seeks every chance she/he can to have fun. It is important to her/him to do things that give her/him pleasure.'
    Q36 'How proud are you to be a citizen of this country'
    Q37 'One of my main goals in life has been to make my parents proud.'
    Q38 'Greater respect for authority.'
    Q39 'How important is religion in your life?'
    Q40 'Independently of whether you attend religious services or not, would you say you are:'
    Q41 'Apart from weddings and funerals, about how often did you usually attend religious services before the Corona-crisis?'
    Q42A1 'Homosexuality'
    Q42A2 'Abortion'
    Q42A3 'Divorce'
    Q43A1 'On the whole, men make better political leaders than women do.' 
    Q43A2 'A university education is more important for a boy than for a girl.'
    Q43A3 'When jobs are scarce, men should have more right to a job than women.'
    Q45A1 'I am someone who is reserved '
    Q45A2 'I am someone who is generally trusting'
    Q45A3 'I am someone who tends to be lazy'
    Q45A4 'I am someone who is relaxed, handles stress well'
    Q45A5 'I am someone who has few artistic interests'
    Q45A6 'I am someone who is outgoing, sociable'
    Q45A7 'I am someone who tends to find fault with others'
    Q45A8 'I am someone who does a thorough job'
    Q45A9 'I am someone who gets nervous easily'
    Q45A10 'I am someone who has an active imagination'
    Q46A1 'I often have tender, concerned feelings for people less fortunate than me.'
    Q46A2 'When I see people being taken advantage of, I feel kind of protective towards them.'
    Q46A3 'I am often quite touched by things that I see happen.'
    Q46A4 'I would describe myself as a pretty soft-hearted person'
    Q53A1 'Maintaining order in the nation'
    Q53A2 'Giving people more say in politics'
    Q53A3 'Fighting rising prices'
    Q53A4 'Protecting freedom of speech'
    Q54A1 'Confidence in government'
    Q54A2 'Confidence in helath sector'
    Q54A8 "Confidence in our country's institutions as a whole"
    Q56A1 'Satisfaction health condition'
    Q56A2 'Satisfaction financial situation'
    Q56A3 'Satisfaction socail realtions'
    Q56A4 'Satisfaction work-life balance'
    Q56A5 'Satisfaction life as a whole'
    Q63A1 'Trust in people you know personally.'
    Q63A2 'Trust in people you meet for the first time.'
    Q64 'Do you think most people would try to take advantage of you if they got a chance, or would they try to be fair? '
    Q65 'How do you feel about people from other countries coming here? '
    Q66 'Turning to the question of ethnic diversity, with which of the views below do you agree?'
    Q68 'Talking about political priorities, do you think that our government should give top priority'
    Q69A1 'Left-Right-Scale'
    weight 'Design weight'
    RQ6A12 'other degree:'
    Q10A1 'Number of adults older than 18 years'
    Q10A2 'Number of adolescents 15-18 years'
    Q10A3 'Number of children 11-14 years'
    Q10A4 'Number of children 6-10 years'
    Q10A5 'Number of children 3-5 years'
    Q10A6 'Number of children 0-2 years'
    Q12 'Main activity'
    RQ12A11 'Other reason for non-working' 
    Q13 'To what extent, if at all, are you concerned that you might lose your job?'
    Q14 'Austrian citizenship'
    Q15 'Where were you born?'
    RQ15A5 'Born in other country'
    Q16 'Where was your biological father born?'
    RQ16A5 'Born in other country'
    Q17 Where was your biological mother born?
    RQ17A5 'Born in other country'
    Q26A1 'More attention will be paid to environmental protection and sustainability.'
    Q26A2 'More and more local products will be bought.'
    Q26A3 'The pressure to perform in the world of work will decrease.'
    Q26A4 'The richer EU countries will generously support those EU countries that are particularly affected by the crisis.'
    Q26A5 'The willingness to accept migrants will decrease.'
    Q26A6 'Professions in trade and nursing will be better paid.'
    Q26A7 'Because of the increased national debt, social benefits will be reduced.'
    Q26A8 'Certain monitoring activities will continue.'
    Q26A9 'The cooperation and consideration for each other will be stronger.'
    Q27A1 "Environmental protection and sustainability must have priority after the corona crisis has been overcome vs. Austria's economic performance must have priority after the corona crisis has been overcome."
    Q27A2 'There should be a wide range of foreign products that everyone can afford vs. we should buy more local products, even if they are more expensive.'
    Q27A3 'In order to ensure economic growth, high performance requirements in the world of work are necessary vs. it would be better for us to reduce the pressure to perform in the world of work.'
    Q27A4 'After the Corona crisis has been overcome, it is necessary that citizens regain all freedoms vs. individual surveillance measures (e.g. via mobile phone data) to protect the population should continue to be used.'
    Q27A5 'EU countries that are not so badly affected should generously support those EU countries that are particularly hard hit vs. each EU country should be responsible for managing the consequences of the Corona crisis.'
    Q27A6 'Migration to Austria should be more strictly regulated after the end of the crisis vs. Austria should focus on immigration again after the crisis because we are dependent on migrants in many areas.'
    Q27A7 'It would be important that we continue to strengthen the cooperation and consideration for others in the future vs.With time, everyone should be able to fully live out their individual needs again.'
    Q27A8 'The differences in income between respected and less respected professions are justified vs. professions in commerce and care should be better paid in the future.'
    Q27A9 'The Austrian welfare state should be further expanded based on the experience of the corona crisis vs. social benefits should be reduced after the corona crisis because of the increased national debt.'
    Q27A10 'It would be better for us and for society if we consume less vs. economic growth and high consumption are ultimately good for all of us.'
    Q27A11 'Everybody should be able to travel by plane as often as he wants vs. travel by plane should be made as seldom as possible.'
    Q27A12 'Those who are severely affected by the crisis should themselves be responsible for managing their difficult situation vs. the state should tax those who earn well more to support those who suffer from the crisis.'
    Q27A13 'Tourism in Austria should be reduced to a reasonable level vs. it is good for Austria if as many foreign tourists as possible come to us.'
    Q29 'How often do you currently use the Internet?'
    Q30A1 'How often you inform yourself about current events through television'
    Q30A2 'How often do you inform yourself about current events through printed media (newspapers etc.)'
    Q30A3 'How often do you inform yourself about current events through online print media (online newspapers etc.) '
    Q30A4 "How often do you stay informed about what's going on through online social networks (Facebook, Twitter, WhatsApp, Snapchat, Instagram, etc.)"
    Q44A1 'A working mother can find as warm a relationship with her children as a mother who is not working.'
    Q44A2 'Men should do a larger share of housework than they do now.'
    Q44A3 "The husband's job is to earn money - the wife's to take care of the household and children."
    Q44A4 'Men should take a greater share of child-rearing than they do now.'
    Q47 'More generally speaking, how concerned are you about environmental problems?'
    Q48A1 '...to pay much higher prices to protect the environment?'
    Q48A2 '...to pay much higher taxes to protect the environment?'
    Q48A3 '...to sacrifice your standard of living to protect the environment?'
    Q49 'There has been much discussion recently about the world climate and the view that it has changed in recent decades. Which of the following statements comes closest to your opinion?'
    Q50 'On a scale of 0 to 10, how bad or good do you think the consequences of climate change will be for AUSTRIA?'
    Q51A1 'A secure professional position'
    Q51A2 'A high income'
    Q51A3 'Good career opportunities'
    Q51A4 'An interesting job'
    Q51A5 'An occupation in which one can work independently'
    Q51A6 'A job where you can help others'
    Q51A7 'A profession that is useful for society'
    Q51A8 'A job where you have personal contact with other people'
    Q52 'How much are you interested in politics?'
    Q54A3 'The Parliament'
    Q54A4 'Commerce and industry'
    Q54A5 'The churches and religious organisations'
    Q54A6 'Courts and the legal system'
    Q54A7 'The schools and the education system'
    Q55A1 'Health'
    Q55A2 'Partnership'
    Q55A3 'Own family and children'
    Q55A4 'job and occupation'
    Q55A5 'Free time'
    Q55A6 'Friends'
    Q55A7 'Relatives'
    Q55A8 'Politics and public life'
    Q57 'In our society there are population groups that tend to be at the top and those that tend to be at the bottom. If you think of yourself, where would you put yourself...'    Q58
    Q59 'And when you think of the months before the Corona crisis, where would you have placed yourself if 1 meant "down" again and 10 meant "up" again?'
    Q60 'Please think of your TOTAL household income, i.e. from all sources of income and from all persons who contribute to it. How difficult or easy is it currently for your household to make ends meet?'
    Q61 'And when you think back to the months before the Corona crisis: Was it difficult or easy for your household to make ends meet?'
    Q62 'And what do you think: How difficult or easy will it be for your household to make ends meet during the next 12 months?'
    Q67 "Would it be okay for you if your (future) son/daughter married a partner from an Islamic country?".
EXECUTE.

*****************************************

* 2.) Define English value labels

*****************************************

* Value in Crisis value labels.
VALUE LABELS Q1 1 'Male' 2 'Female' 3 'Diverse'.
VALUE LABELS Q7 1 'Married' 2 'Living together as married' 3 'Divorced' 4 'Separated' 5 'Widowed' 6 'Single, never married'.
VALUE LABELS VIC05 1 'Compulsory school' 2 'Apprenticeship' 3 'Vocational middle school (e.g. commercial school)' 
        4 'General secondary school (AHS)' 5 'Vocational secondary school (BHS, e.g. HAK, HTL)'
        6 'Bachelor at university of applied sciences/ teacher training college'
        7 'Bachelor at university' 8 'Diploma degree / Master at university of applied sciences'
        9 'Diploma degree / Master at university' 10 'Postgraduate university course (based on a diploma degree, e.g. MBA)'
        11 'Doctorate' 12 'Another degree, which is...'.
VALUE LABELS Q11 1 'less than 450 Euro' 2 '450 to 599 Euro' 3 '600 to 749 Euro' 4 '750 to 899 Euro' 5 '900 to 1.124 Euro'
        6 '1.125 to 1.349 Euro' 7 '1.350 to 1.649 Euro' 8 '1.650 to 1.949 Euro' 9 '1.950 to 2.249 Euro' 10 '2.250 to 2.699 Euro'
        11 '2.700 to 3149 Euro' 12 '3.150 to 3.599 Euro' 13 '3.600 to 4.049 Euro' 14 '4.050 to 4.499 Euro' 
        15 '4.500 to 5.499 Euro' 16 '5.500 to 6.499 Euro' 17 '6.500 to 7.999 Euro' 18 '8.000 Euro and more'.
VALUE LABELS Q5 1 'A big city' 2 'The suburbs or outskirts of a big city' 3 'A town or a small city' 
        4 'A country village' 5 'A farm or home in the countryside'.
VALUE LABELS Q4 1 'Vorarlberg' 2 'Tyrol' 3 'Salzburg' 4 'Styria' 5 'Carinthia' 6 'Upper Austria'
        7 'Lower Austria' 8 'Vienna' 9 'Burgenland'  10 'I do not live in Austria'.
VALUE LABELS Q18A1 TO Q19A7 1 'Yes, I have experienced' 2 'No, I have not experienced'.
VALUE LABELS Q20 Q21 1 'Very afraid' 2 'Quite afraid' 3 'Neither, nor' 4 'Not very afraid' 5 'Not at all afraid'.
VALUE LABELS Q22 1 'Very poorly' 2 'Quite poorly' 3 'Neither, nor' 4 'Quite well' 5 'Very well '.
VALUE LABELS Q23 1 'Very improper' 2 'Quite improper' 3 'Neither, nor' 4 'Quite proper' 5 'Very proper '.  
VALUE LABELS Q24 -3 'More hostility' 0 'It depends' 3 'More solidarity'.    
VALUE LABELS Q25 1 'Severely hurt' 2 'Neither, nor' 3 'Greatly strengthened'. 
VALUE LABELS Q28A1 TO Q28A5 1 'Not at all' 2 'Several days' 
    3 'More than half the days' 4 'Nearly every day'. 
VALUE LABELS Q31 1 'Yes, I do believe in these stories.' 2 'No, I don’t believe in these stories.'.
VALUE LABELS Q32 1 'Social media are most credible' 3 'Both the same' 5 'Traditional media are most credible'.
VALUE LABELS SVSA1 TO SVSA22 1 'Very much like me' 2 'Like me' 
    3 'Somewhat like me' 4 'A little like me' 5 'Not like me' 6 'Not at all like me'.
VALUE LABELS Q36 1 'Very proud' 2 'Quite proud' 3 'Not very proud' 4 'Not at all proud' 
    5 'I am not a citizen of this country'.
VALUE LABELS Q37 1 'Strongly agree' 2 'Agree' 3 'Disagree' 4 'Strongly disagree'.
VALUE LABELS Q38 1 'Do I welcome' 2 "I don't" 3 'I refuse'.
VALUE LABELS Q39 1 'Very important' 2 'Rather important' 3 'Not very important' 4 'Not at all important'.
VALUE LABELS Q40 1 'A religious person' 2 'Not a religious person' 3 'An atheist'.
VALUE LABELS Q41 1 'More than once a week' 2 'Once a week' 3 'Once a month' 
    4 'Only on special holidays' 5 'Once a year' 6 'Less often' 7 'Never, practically never'.
VALUE LABELS Q42A1 TO Q42A3 1 'Never justifiable' 10 'Always justifiable'.
VALUE LABELS Q43A1 TO Q43A3 1 'Strongly agree' 2 'Agree' 3 'Disagree' 4 'Strongly disagree'.
VALUE LABELS Q45A1 TO Q45A10 1 'Disagree strongly' 2 'Disagree a little' 3 'Neither, nor'
    4 'Agree a little' 5 'Agree strongly'. 
VALUE LABELS Q46A1 TO Q46A4 1 'Does not describe me at all' 5 'Describe me perfectly well'.
VALUE LABELS Q53A1 TO Q53A4 1 'Most important' 2 'Second-most important' 9 'Not applicable'. 
VALUE LABELS Q54A1 TO Q54A8 1 'A great deal' 2 'Quite a lot' 3 'Not very much' 4 'None at all'.
VALUE LABELS Q56A1 TO Q56A5 1 'Completely dissatisfied' 10 'Completely satisfied'.
VALUE LABELS Q63A1 Q63A2 1 'Trust completely' 2 'Trust somewhat' 3 'Do not trust very much' 4 'Do not trust at all'.
VALUE LABELS Q64 1 'Would try to take advantage' 10 ' Would try to be fair'.
VALUE LABELS Q65 
    1 'Let anyone come to Austria who wants to come.'
    2 'Allow immigration as long as jobs are available.'
    3 'Strictly limit the number of foreigners entering the country.'
    4 'Generally prohibit the entry of foreigners'.
VALUE LABELS Q66 1 'Ethnic diversity erodes social cohesion' 10 'Ethnic diversity enriches social life'.
VALUE LABELS Q68 1 'Solving our own problems by ourselves' 10 'Solving global problems in cooperation'.
VALUE LABELS Q69A1 1 'Left' 10 'Right'.
VALUE LABELS SV1 TO SV21 SEcuritycenter TO POwercenter 
    1 'Very much like me' 2 'Like me' 3 'Somewhat like me' 4 'A little like me' 5 'Not like me' 6 'Not at all like me'.

* SSÖ value labels.
VALUE LABELS Q12 1 'Employed' 2 'In short-time work' 3 'Trainee' 4 'Unemployed' 5 'Parental leave'
    6 'civil service, military service' 7 'Pensioner' 8 'Housewife' 9 'Pupil/Student' 10 'Unable to work, in invalidity pension'
    11 'other reasons'.
VALUE LABELS Q13 1 'I am very worried' 2 "I am a little bit worried" 3 "I have few worries" 4 "I am not worried at all".
VALUE LABELS Q14 1 'Yes, since birth.' 2 'Yes, acquired later' 3 'No'.
VALUE LABELS Q15 1 "Austria" 2 "Former Yugoslavia" 3 "Turkey" 4 "Germany" 5 "Other country".
VALUE LABELS Q16 Q17 1 "Austria" 2 "Former Yugoslavia" 3 "Turkey" 4 "Germany" 5 "Other country" 6 "I don't know".
VALUE LABELS Q26A1 TO Q26A9 1 'Very unlikely' 2 'Rather unlikely' 3 'either' 4 'Rather likely' 5 'Very likely' 8 "I don't know".
VALUE LABELS Q27A1 1 'Environmental protection and sustainability' 7 "Austria's economic performance".
VALUE LABELS Q27A2 1 'Wide range of foreign products' 7 "More local products".
VALUE LABELS Q27A3 1 'High performance requirements in the world of work' 7 "Reduce the pressure to perform in the world of work".
VALUE LABELS Q27A4 1 'Regain all freedoms of citizens' 7 "Continue individual surveillance to protect population".
VALUE LABELS Q27A5 1 'Generously support from less badly hit EU countries to particularly hard hit EU countries' 7 "Each EU country manages the consequences alone".
VALUE LABELS Q27A6 1 'Migration should be more strictly restricted' 7 "Focus on immigration again after crisis".
VALUE LABELS Q27A7 1 'Continue strengthen the cooperation' 7 "Live out their individual needs again".
VALUE LABELS Q27A8 1 'Income differences are justified' 7 "Commerce and care jobs should be better paid".
VALUE LABELS Q27A9 1 'Austrian welfare state should be further expanded' 7 "Social benefits should be reduced".
VALUE LABELS Q27A10 1 'Less consumption is better for society' 7 "High consumptioin are ultimately good for all of us".
VALUE LABELS Q27A11 1 'Travel by plane as often as he wants' 7 "Travel by plane as seldom as possible".
VALUE LABELS Q27A12 1 'Severely affected should manage their difficult situation themselves' 7 "State should tax high earners more to support people suffering from the crisis".
VALUE LABELS Q27A13 1 'Tourism should be reduced' 7 "Tourism should be maximized".
VALUE LABELS Q29 1 'Over 6 hours daily' 2 'About 3 to 6 hours daily' 3 'About 1 to under 3 hours daily'
    4 'Several times a week' 5 'Several times a month' 6 'Almost never' 7 'Never' 8 'I cannot say'.
VALUE LABELS Q30A1 TO Q30A4 1 'Very often' 2 'Often' 3 'Sometimes' 4 'Rarely' 5 'Never' 6 'I cannot say'.
VALUE LABELS Q44A1 To Q44A4 1 'Strongly agree' 2 'Agree' 3 'Neither' 4 'Disagree' 5 'Strongly disagree' 8 'I cannot say'.
VALUE LABELS Q47 1 'No worries at all' 5 'Very big worries' 9 'I cannot say'.
VALUE LABELS Q48A1 TO Q48A3 1 'Very acceptable' 2 'Rather acceptable' 3 'Neither acceptable nor unacceptable' 
    4 'Rather unacceptable' 5 'Unacceptable' 9 'I cannot say'.
VALUE LABELS Q49 1 'The world climate has not changed' 
    2 'The global climate has changed mainly due to natural processes'
    3 'The world climate has changed in roughly equal parts by natural processes and by human activity'
    4 'The world climate has changed mainly through human activity'
    9 'I cannot say'.
VALUE LABELS Q50 0 'Extremely bad' 10 'Extremely good' 99 'I cannot say'.
VALUE LABELS Q51A1 TO Q51A8 1 'Very important' 2 'Rather important' 3 'Neither' 4 'Rather not important' 5 'Not important at all' 8 'I cannot say'.
VALUE LABELS Q52 1 'Very strong' 2 'Rather strong' 3 'Average' 4 'A little' 5 'Not at all'.
VALUE LABELS Q54A3 TO Q54A7 1 'Very much trust' 2 'Quite a lot of trust' 3 'Little trust' 4 'No trust et all'.
VALUE LABELS Q55A1 TO Q55A8 1 'Unimportant' 7 'Very Important'.
VALUE LABELS Q57 TO Q59 1 'At the bottom' 10 'At the top' 99 "I don't know".
VALUE LABELS Q60 TO Q62 1 'Very difficult' 2 'Rather difficult' 3 'Neither' 4 'Rather easy' 5 'Very easy' 9 'I cannot say'.
VALUE LABELS Q67 1 'Yes, by all means' 2 'Maybe' 3 'Rather not' 4 'By no means' 5 'I cannot say'.

*****************************************

* 3.) Translate open questions

*****************************************

RECODE RQ6A12 
    ("Akademie" = "Academy")
    ("akademischen Handelsmanager" = "Academic trade manager")
    ("Handelsmanager" = "Trade manager")
    ("Aspirant" = "Aspirant")
    ("Bhs" = "BHS")
    ("H" = "Unidentifable entry")
    ("Kollege" = "College")
    ("Kurzstudium" = "Short study")
    ("Lehre mit Matura" = "Apprenticeship with Matura")
    ("Mag.rer.nat." = "Mag.rer.nat.")
    ("Magistra" = "Magistra")
    ("Mechaninkermeister" = "Master mechanic")
    ("Meisterprüfung" = "Master's certificate")
    ("Universitätslehrgang Werbung und Verkauf" = "University course in advertising and sales")
    ("xxx" = "Unidentifable entry").

RECODE RQ12A11
    ("Arbeitslos, wurde gerade gekündigt, aber mache bereits eine Ausbildung in Naturheilkunde" = "Unemployed, has just been dismissed, but is already training in naturopathy")
    ("aus Ermangelung an Jobangeboten für meine Altersklasse" = "For lack of job offers for my age group")
    ("Bin pflegende Angehörige" = "I am a family caregiver")
    ("Finde keine Arbeit" = "Do not find work")
    ("freiberuf keine aufträge" = "Freelance no orders")
    ("Freigestellt" = "Released")
    ("Gesundheit" = "Health")
    ("Gesundheitliche Gründe" = "Health reasons")
    ("Hotel aufgrund Corona geschlossen" = "Hotel closed due to Corona")
    ("Ich auf Therapie bin" = "I am in therapy")
    ("Krankenstand" = "Sick leave")
    ("Krankenstand und warte auf op" = "Sick leave and waiting for surgery")
    ("Pension" = "Pension")
    ("Psychische Probleme." = "Mental problems")
    ("Selbstständig.. Wegen Corona nichts" = "Self-employed... Because of Corona nothing")
    ("umschulung" = "Retraining")
    ("weil ich zu viel esse" = "because I eat too much").

RECODE RQ15A5
    ("Argentinien" = "Argentina")
    ("Bd" = "Bangladesh")
    ("belgien" = "Belgium")
    ("Belgien" = "Belgium")
    ("Bulgarien" = "Bulgaria")
    ("Chile" = "Chile")
    ("CSSR" = "CSSR")
    ("England" = "England")
    ("in derSchweiz als Österreicherin geboren" = "born in Switzerland as an Austrian")
    ("Irak" = "Iraq")
    ("Iran &#127470;&#127479;" = "Iran")
    ("Italien" = "Italy")
    ("Kenia" = "Kenya")
    ("Kosovo" = "Kosovo")
    ("Kroatien" = "Croatia")
    ("Kuba" = "Cuba")
    ("Mkd" = "Macedonia")
    ("Österreich" = "Austria")
    ("Philippinen" = "Philippines")
    ("Polen" = "Poland")
    ("Rumänien" = "Romania")
    ("Russland" = "Russia")
    ("Saudi-arabien" = "Saudi-Arabia")
    ("Saudi-Arabien" = "Saudi-Arabia")
    ("Schweiz" = "Switzerland")
    ("Slowakei" = "Slovakia")
    ("Slowenien" = "Slovenia")
    ("Spanien" = "Spain")
    ("Tschechien" = "Czech Republic")
    ("Tunesien" = "Tunesia")
    ("UdSSR" = "Former Soviet Union")
    ("Ukraine" = "Ukraine")
    ("Vietnam" = "Vietnam").
    
RECODE RQ16A5
    ("-" = "Unidentifable entry")
    ("." = "Unidentifable entry")
    ("&#127964;" = "Unidentifable entry")
    ("Ägypten" = "Egypt")
    ("Albanien" = "Albania")
    ("Argentinien" = "Argentina")
    ("Bd" = "Bangladesh")
    ("belgien" = "Belgium")
    ("Belgien" = "Belgium")
    ("Budapest" = "Budapest")
    ("Bulgarien" = "Bulgaria")
    ("Chile" = "Chile")
    ("CSSR" = "CSSR")
    ("Dänemark" = "Denmark")
    ("England" = "England")
    ("frankreich" = "France")
    ("Frankreich" = "France")    
    ("Geht Sie nichts an" = "None of your business")
    ("Griechenland" = "Greece")
    ("Großritannien" = "Great Britain")
    ("Indien" = "India")
    ("Irak" = "Iraq")
    ("Iran &#127470;&#127479;" = "Iran")
    ("italien" = "Italy")
    ("Italien" = "Italy")
    ("Kambodscha" = "Cambodscha")
    ("keine Angabe" = "Not reported")
    ("Kosovo" = "Kosovo")
    ("kroatp" = "Croatia")
    ("Kuba" = "Cuba")
    ("Mazedonien" = "Macedonia")
    ("Mkd" = "Macedonia")
    ("Nicaragua" = "Nicaragua")
    ("Niederlande" = "Netherlands")
    ("Nl" = "Netherlands")
    ("Österreich" = "Austria")
    ("Pakistan" = "Pakistan")
    ("Persien" = "Persia")
    ("Philippinen" = "Philippines")
    ("Polen" = "Poland")
    ("R0m" = "Romania")
    ("rumänien" = "Romania")
    ("Rumänien" = "Romania")
    ("Rumänien 1938" = "Romania")
    ("Russland" = "Russia")
    ("Schlesien" = "Silesia")
    ("Schweiz" = "Switzerland")
    ("Schweoz" = "Switzerland")
    ("Siebenbürgen - Rumänien" = "Transylvania - Romania")
    ("Slowakei" = "Slovakia")
    ("Slowenien" = "Slovenia")
    ("Spanien" = "Spain")
    ("Sudeten Deutschland" = "Sudeten Germany")
    ("Sudetenland Tschechien" = "Sudetenland Czech Republic")
    ("Südtirol" = "South Tyrol")
    ("Syrien" = "Syria")
    ("Tschechei" = "Czech Republic")
    ("tschechien" = "Czech Republic")
    ("Tschechien" = "Czech Republic")
    ("tschechien (sudetenland)" = "Sudetenland Czech Republic")
    ("Tschechien, Sudetendeutscher" = "Sudetenland Czech Republic")
    ("Tschechoslovakei" = "Czechoslovakia")
    ("Tschechoslowakei" = "Czechoslovakia")
    ("Tunesien" = "Tunesia")
    ("UdSSR" = "Former Soviet Union")
    ("Ukraine" = "Ukraine")
    ("Ungarn" = "Hungary")
    ("vietnam" = "Vietnam")
    ("Vietnam" = "Vietnam").

RECODE RQ17A5   
    ("Ägypten" = "Egypt")
    ("Albanien" = "Albania")
    ("Argentinien" = "Argentina")
    ("Bd" = "Bangladesh")
    ("belgien" = "Belgium")
    ("Belgien" = "Belgium")
    ("Budapest" = "Budapest")
    ("Bulgarien" = "Bulgaria")
    ("Chile" = "Chile")
    ("Das geht Sie nichts an" = "None of your business")
    ("England" = "England")
    ("Griechenland" = "Greece")
    ("in der Tschechoslowakei" = "Czechoslovakia")
    ("Indien" = "India")
    ("Indonesien" = "Indonesia")
    ("Irak" = "Iraq")
    ("Iran &#127470;&#127479;" = "Iran")
    ("italien" = "Italy")
    ("Italien" = "Italy")
    ("Italien( Südtirol)" = "Italy (South Tyrol)")
    ("Kambodscha" = "Cambodscha")
    ("keine Angabe" = "Not reported")
    ("Kosovo" = "Kosovo")
    ("Kuba" = "Cuba")
    ("Mazedonien" = "Macedonia")
    ("Mkd" = "Macedonia")
    ("Niederlande" = "Netherlands")
    ("Nigeria" = "Nigeria")
    ("oberitalien" = "Northern Italy")
    ("österreich" = "Austria")
    ("Pakistan" = "Pakistan")
    ("Philippinen" = "Philippines")
    ("polen" = "Poland")
    ("Polen" = "Poland")
    ("Rom" = "Romania")
    ("rumänien" = "Romania")
    ("Rumänien" = "Romania")
    ("Russland" = "Russia")
    ("Schottland" = "Scotland")
    ("Schweiz" = "Switzerland")
    ("Siebenbürgen - Rumänien" = "Transylvania - Romania")
    ("Slovakei" = "Slovakia")
    ("Slowakei" = "Slovakia")
    ("Slowenien" = "Slovenia")
    ("Spanien" = "Spain")
    ("Sudetendeutschland" = "Sudeten Germany")
    ("südtirol" = "South Tyrol")
    ("Südtirol" = "South Tyrol")
    ("Syrien" = "Syria")
    ("Tschechei" = "Czech Republic")
    ("tschechien" = "Czech Republic")
    ("Tschechien" = "Czech Republic")
    ("Tschechische Republik" = "Czech Republic")
    ("Tschechoslowakei" = "Czechoslovakia")
    ("Tschechoslowakei - heute Tschechien (Böhmen)" = "Czechoslovakia - today Czech Republic (Bohemia)")
    ("Tunesien" = "Tunesia")
    ("UdSSSR" = "Former Soviet Union")
    ("UK" = "United Kingdom")
    ("Ukraine" = "Ukraine")
    ("ungarn" = "Hungary")
    ("Ungarn" = "Hungary")
    ("vietnam" = "Vietnam")
    ("Vietnam" = "Vietnam").    


*****************************************

* 4.) Define missing values

*****************************************

MISSING VALUES Q36 Q67 (5).
MISSING VALUES Q16 Q17 Q30A1 TO Q30A4  (6).
MISSING VALUES Q26A1 TO Q26A9 Q29  Q44A1 To Q44A4 Q51A1 TO Q51A8  (8).
MISSING VALUES Q53A1 TO Q53A4 Q47 Q48A1 TO Q48A3 Q60 TO Q62 (9).
MISSING VALUES Q50 Q57 TO Q59 (99).

SAVE OUTFILE='Values in Crisis Survey Austria_data English v02.sav'
  /COMPRESSED.


