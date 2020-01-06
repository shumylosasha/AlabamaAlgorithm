//
//  CheckSentenceData.swift
//  EnglishPlanet
//
//  Created by Serhiy Vysotskiy on 2/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

extension CheckSentence {
    var data: CheckSentenceData {
        return CheckSentenceData(self)
    }
}

struct CheckSentenceData {
    let sentence: CheckSentence
    let data: [TranslateProducerPair]
    
    var sentences: [String] {
        return data.map { $0.sentenceToTranslate }
    }
    
    var producers: [String] {
        return data.map { $0.producer }
    }
    
    var count: Int {
        return data.count
    }
}

extension CheckSentenceData {
    init(_ sentence: CheckSentence) {
        var sentences = [String]()
        var producers = [String]()
        
        switch sentence {
        case .Onboarding_translations:
           sentences = [
                "Я хожу в зал каждую неделю.",
            ]
            
            producers = [
                " >>[every week, weekly] I go{2} to{200} the{257} gym >><.",
            ]
            
        case .Taco_item_door:
            sentences = [
                "Я люблю такос",
            ]
            
            producers = [
                " [I love{1}, I like{1}, {I'm}{197} in love with] tacos{262}",
            ]
            
        case .level1:
            sentences = [
                "Мой самолёт прилетает в 7.",
                "Что это означает?",
                "Она не водит машину.",
                "Все больше и больше людей путешествуют сейчас.",
                "Они переезжают на новую квартиру в пятницу.",
                "Ты дома? Нет, я на работе.",
                "Мой брат не знает китайский.",
                "Подожди минутку, я стараюсь вспомнить его имя.",
                "Я сейчас сбрасываю вес.",
                "Она ещё спит.",
                "Мой босс постоянно кричит на меня!",
                "Я сейчас занят, я говорю по телефону.",
                "Я убираю свою квартиру каждую пятницу.",
                "Мой начальник обожает спорт.",
                "Он редко приглашает в кино свою девушку.",
            ]
            
            producers = [
                ">>[at seven, at seven o'clock, at 7, at 7 o'clock] my [airplane, plane] [comes{4}, arrives{4}, lands{4}] >><.",
                 "what{268} does{1} [it, this, that] mean{268}?",
                 "she [(does not drive){1}, (doesn't drive){1}, (never drives){1}, (can not){156} drive, (can't){156} drive, cannot{156} drive] a{250} car.",
                 ">>[now, at the moment, at present, these days, nowadays]{8} [more{280}, (more and more){280}] people{262} [(are traveling){13}, (are travelling){13}] >><.",
                 ">>[on Friday]{8} [they (are moving){14}, they're moving{14}] [into{200}, to{200}] a{250} new [flat, apartment] >><.",
                 "are{197} you /at home? /No, [I am{197}, I'm{197}] [at{223} work, in{220} the{257} office, working].",
                 "my brother [(does not){1}, doesn't{1}] [know{1}, speak{1}] Chinese.",
                 " [wait{272}, wait{272} a minute], [I (am trying){11}, I'm trying{11}] to{201} [remember, recall, recollect] (his name){264}.",
                 ">>[now, nowadays, at present, these days]{8} [(I'm losing){12}, (I'm trying){12} to lose, I (am losing){12}, I (am trying){12} to lose] weight{263} >><.",
                 " [she is, she's] still<{9} sleeping{11}.",
                 "my{264} [boss is, chief is, superior is, boss's, chief's, superior's] [constantly<{9}, always<{9}] [screaming{15}, shouting{15}, yelling{15}] at me!",
                 " [/now, /(at the moment)] [I am{197}, I'm{197}] busy, [(I'm speaking){11}, (I'm talking){11},(I am speaking){11}, (I am talking){11}] [by phone, by telephone, on the phone, on the telephone] [/now, /(at the moment)].",
                 ">>[every Friday, on Friday, on Fridays]{8} I clean{2} [(my flat){264}, (my apartment){264}] >><.",
                 "my [boss, chief] [likes{1} sport{263}, likes{1} sport{263} very much, loves{1} sport{263} very much, loves{1} sport{263}, really{248} loves{1} sport{263}, absolutely loves{1} sport{263}].",
                 "he rarely<{9} invites{2} his girlfriend to{200} the{257} [cinema, movies, movie theatre, movie theatre].",
            ]
        case .level2:
            sentences = [
                "Она приедет завтра или послезавтра?",
                "Ты часто куришь, не так ли?",
                "Эмма из Италии, итальянцы очень красивые.",
                "Ты любишь апельсиновый сок?",
                "Он ходит в спортзал 3 раза в неделю.",
                "Они приедут к нам завтра?",
                "Вы идёте сейчас в парк, не так ли?",
                "Она пишет новую книгу в настоящий момент.",
                "Я планирую съездить в США этим летом.",
                "Почему она всегда грустная?",
                "Она сейчас не спит, не так ли?",
                "Что ты делаешь?",
                "Скорпионы очень опасны.",
                "Разве она не знает об этом?",
                "Мы сегодня встречаемся в кафе или в баре?",
                
            ]
            
            producers = [
                " [(will she come){42}, (is she coming){14}, (is she going){56} to come, (is she planning){14} to come] tomorrow or{269} the day after tomorrow?",
                "you often<{9} smoke{2}, [(do you not){270}, (don't you){270}]?",
                " [emma is{197}, emma's{197}, emma comes{197}] from Italy{261}, the{258} Italians are{197} [very{249}, really{248}] [beautiful, pretty].",
                "do{266} you [like{1}, love{1}] orange juice{263}?",
                ">>[3 times a week, three times a week] he goes{2} to{200} the{257} gym >><.",
                " [will{266} they come{42}, are{266} they coming{14}] to{200} us tomorrow?",
                 " [(you are going){14}, (you're going){14}] to{200} the{257} park /now [(aren't you){270}, (are you not){270}]?",
                ">>[nowadays, at present, these days, now]{8} [she (is writing){12}, (she's writing){12}] a{250} new book >><.",
                ">>[this summer]{8} [I am, I'm] [planning to{202}, (going to){56}] go to{200} the{258} [USA, United States, United States of America, us, US] >><.",
                " [why{268} is{197}, why's{268}] she always{10} [sad, upset, gloomy]?",
                ">[now, at the moment]{8} [she (is not sleeping){11}, she (isn't sleeping){11}, (she's not sleeping){11}] ><, (is she){271}?",
                "what{268} are you doing{11}?",
                "scorpions{262} are{197} [very{249}, really{248}] dangerous.",
                " [(does she not){267}, (doesn't she){267}] know{16} about{239} [it, this, that]?",
                " [(will we meet){42}, (are we meeting){14}, (are we going){56} to meet, (are we planning){14} to meet] in{220} [a, the] cafe or{269} in{220} [a, the] bar today?",
                
            ]
        case .level3:
            sentences = [
                "Последний поезд в Берлин отходит в полночь.",
                "На рождество мы планируем навестить наших родственников.",
                "Она планирует улететь в Париж этим летом, чтобы увидеть Эйфелеву Башню.",
                "Что она любит делать по выходным?",
                "Давай встретимся в пятницу вечером.",
                "Я улетаю в Китай на этой неделе в субботу.",
                "Она звонит маме каждую среду.",
                "Они планируют съездить в Италию в мае.",
                "Я сейчас иду в магазин, чтобы купить вино.",
                "Чтобы приготовить омлет, тебе нужно купить яйца и молоко.",
                "Мы обсуждаем этот вопрос в настоящий момент.",
                "Ночью ты сможешь увидеть звёзды на небе.",
                "Поверни на лево на светофору.",
                "Он сейчас в командировке.",
            ]
            
            producers = [
                "the{253} last train to{200} Berlin [is{197}, leaves{4}, departs{4}] at{212} midnight.",
                ">>[at Christmas, on Christmas Day]{8} [we (are planning){14} to{201}, (we're planning){14} to{201}, (we are going to){56}, (we're going to){56}] [visit (our relatives){264}, visit (our family){264}, give (our relatives){264} a visit, give (our family){264} a visit] >><.",
                ">>[this summer]{8} [she (is planning){14} to{201}, (she's planning){14} to{201}, she (is going to){56}, (she's going to){56}] fly to{200} Paris{261} to{202} see the{260} Eiffel Tower >><.",
                "what{268} does she like{1} doing{151} [(on weekends){218}, (at the weekend){214}]?",
                " [(let us){272}, let's{272}] [meet, see each other, have a{250} meeting] [on{216} Friday evening, on{215} Friday in{205} the evening, in{205} the evening on{215} Friday].",
                ">>[this week on Saturday, on Saturday this week, this Saturday]{8} [I (am flying){14}, (I'm flying){14}, I (am going){14}, (I'm going){14}, I (am travelling){14}, (I'm travelling){14}, I (am traveling){14}, (I'm traveling){14}] to{200} China >><.",
                ">>[every Wednesday]{8} she [calls{2}, phones{2}] [(her mother){264}, (her mom){264}, (her mum){264}] >><.",
                ">>[in May]{8} [they (are planning){14} to{201}, they're planning{14} to{201}, (they are going to){56}, (they're going to){56}] [go, travel] to{200} Italy{261} >><.",
                "/now [I (am going){11} to{200}, (I'm going){11} to{200}, I (am going){11} to{200} go, (I'm going){11} to{200} go]  the{257} [shop, store] to{202} buy /some wine{263} /now.",
                "to{202} [make, prepare, cook] an{250} omelette, you need{1} to{201} [buy, purchase, get] /some eggs{262} and /some milk{263}.",
                ">>[now, at the moment, right now]{8} [we (are discussing){11}, (we're discussing){11}, we (are talking){11} about{238}, (we're talking){11} about{238}] [this, that] question >><.",
                ">>[at night]{8} you can{169} see (the stars){260} in{220} (the sky){260}>><.",
                " [(Turn left){272}, (take a left turn){272}] at{224} the{257} traffic lights.",
                " [he is{197}, he's{197}] on{203} a{250} business trip.",
                
            ]
        case .level4:
            sentences = [
                "Если ты голоден, я приготовлю что-то покушать.",
                "Эта блузка стоит всего 15 долларов, я куплю ее.",
                "В следующем году я пробегу марафон.",
                "Посмотри на эту машину! Она сейчас врежется в это дерево.",
                "Поторопись! Спектакль начнётся через 5 минут.",
                "Я приму решение завтра.",
                "Я не планирую приходить туда завтра.",
                "В котором часу мы планируем встретится завтра?",
                "Они возможно спросят тебя об этом.",
                "Возможно мы получим эту посылку сегодня.",
                "Она не будет с тобой разговаривать.",
                "Не переживай, я заплачу за тебя.",
                "Я перезвоню тебе через 5 минут.",
                "Посмотри на небо! Сейчас точно пойдёт дождь.",
                "Я планирую дописать свою книгу в след году.",
                "Мой отец планирует купить новую машину в этом году.",
                "Я никогда тебя не прощу.",
                "Я пойду на эту вечеринку, если он меня пригласит.",
                "Однажды я стану известным актером.",
                "Ее родители купят ей новую игрушку сегодня.",
            ]
            
            producers = [
                "if [you are{197}, you're{197}] hungry{111}, [I (will cook){111}, I (will make){111}, I (will prepare){111}, (I'll cook){111}, (I'll make){111}, (I'll prepare){111}] something [/to eat, ].",
                " [this, that] [blouse costs{16}, blouse is{197}, blouse's{197}] [/just, /only] [15 dollars, fifteen dollars, 15$], [I (will buy){45}, (I'll buy){45}] it.",
                ">>[next year]{8} [I (will run){42}, (I'll run){42}] [a{250}, this, that] marathon >><.",
                "look{272} at{242} [this, that] car! [it (is going to){57}, (it's going to){57}] [break{57}, bump{57}, crash{57}] [into{200}, to{200}] [this, that] tree!",
                " [hurry{272}, (hurry up){272}]! The{253} [play, show, performance] [starts{4}, begins{4}] in{211} [5 minutes, five minutes, 5 min, five min].",
                ">>[tomorrow]{8} [I'll{44}, I will{44}] [decide{44}, make{44} a{250} decision, take{44} a{250} decision, make{44} my decision{264}, make this decision, make that decision, take this decison, take that decision, make this decision, make that decision] >><.",
                ">>[tomorrow]{8} [I am not, I'm not] [(going to go){58}, (going to come){58}] there >><.",
                " [when{268}, (what time){268}] (are we going to){56} [meet{56}, see{56} each other] tomorrow?",
                "they [will{42} /probably, may{188}, might{188}] ask you about{238} [this, it, that].",
                ">>[today]{8} [we will{42}, we'll{42}] probably<{9} [get{42}, receive{42}] [this, the{253}, that] [delivery, parcel]>><.",
                " [she (will not){43}, (she'll not){43}, she won't{43}] [(talk to){43}, (speak to){43}, (speak with){43}] you.",
                 " [(do not worry){273}, (don't worry){273}, no worries]! [I (will pay){45}, (I'll pay){45}] for you.",
                ">>[in five minutes, in 5 minutes, in 5 min] [I will{44}, I'll{44}] [call{44} you, call{44} you back, return{44} your call] >><.",
                "look{272} at{242} the{260} sky! [it (is going to rain){57}, (it's going to rain){57}] /now!",
                ">>[next year]{8} [(I am going to write){56}, (I am going to finish){56}, (I'm going to write){56}, (I'm going to finish){56}] (my book){264} >><.",
                ">>[this year]{8} my [father is, dad is, father's, dad's] [(going to buy){58}, (going to purchase){58}] a{250} new car >><.",
                " [I'll{44}, I will{44}] never<{9} forgive{44} you.",
                " [I (will go){111}, I (will come){111}, (I'll go){111}, (I'll come){111}] to{200} [the{253}, this, that] party, if he invites{111} me.",
                ">>[one day]{8} [(I will be){43}, (I'll be){43}, (I will become){43}, (I'll become){43}] a{251} famous actor >><.",
                ">>[today]{8} her parents (will buy){44} her a{250} new toy >><.",
                
            ]
            
        case .presentSimple_t_1:
            sentences = [
                "Он пьёт кофе каждый день.",
                "Она делает домашнее задание по вечерам.",
                "Дельфины живут в воде.",
                "Мой самолёт прилетает в 7.",
            ]
            
            producers = [
                ">>[every day]{8} he [drinks{2}, has{2}] [coffee{263}, (some coffee){263}, a<{250} cup of coffee] >><.",
                ">>[in the evening, in the evenings]{8} she does{2} /her homework >><.",
                "dolphins live{3} in{220} water{263}.",
                ">>[at seven, at seven o'clock, at 7, at 7 o'clock] my [airplane, plane] [comes{4}, arrives{4}, lands{4}] >><.",
            ]
                
        case .presentSimple_t_2:
            sentences = [
                "Они часто навещают нас.",
                "Мой брат не знает китайский.",
                "Мой начальник обожает спорт.",
                "Каждое утро я езжу на работу на метро.",
                
            ]
            
            producers = [
                "they often<{9} [visit{2}, come{2} to{200}] us.",
                "my brother [(does not){1}, doesn't{1}] [know{1}, speak{1}] Chinese.",
                "my [boss, chief] [likes{1} sport{263}, likes{1} sport{263} very much, loves{1} sport{263} very much, loves{1} sport{263}, really{248} loves{1} sport{263}, absolutely loves{1} sport{263}].",
                ">>[every morning]{8} I go{2} to{200} work{263} by{237} [metro, subway, underground] >><.",
                
            ]
                
        case .presentSimple_t_3:
            sentences = [
                "Когда ты обычно просыпаешься?",
                "Где она живет?",
                "Почему она редко звонит нам?",
                "Что это означает?",
                
            ]
            
            producers = [
                " [(when do){268}, (what time do){268}] you usually<{9} [(wake up){2}, (get up){2}]?",
                "where{268} does{1} she live{268}?",
                "why{268} does{2} she [rarely<{9}, seldom<{9}] [call{268}, phone{268}] us?",
                "what{268} does{1} [it, this, that] mean{268}?",
                
            ]
                
        case .presentSimple_t_4:
            sentences = [
                "Мы иногда остаёмся дома на выходных.",
                "Он редко курит.",
                "Нам не нравится этот фильм.",
                "Каждый понедельник моя подруга ходит в зал.",
            ]
            
            producers = [
                ">>[at the weekend, on weekends]{8} we sometimes<{9} stay{2} /home >><.",
                "he [rarely<{9}, seldom<{9}] smokes{2}.",
                "we [(do not like){1}, (don't like)){1}, dislike{1}] [this, that] [film, movie].",
                ">>[every Monday, on Monday, on Mondays]{8} [(my friend){264}, (my girlfriend){264}] goes{2} to{200} the{257} gym >><.",
                
            ]
                
        case .presentSimple_t_5:
            sentences = [
                "Я убираю свою квартиру каждую пятницу.",
                "Ты знаешь его имя?",
                "Как часто она ходит в кино?",
                "Она не водит машину.",
            ]
            
            producers = [
                ">>[every Friday, on Friday, on Fridays]{8} I clean{2} [(my flat){264}, (my apartment){264}] >><.",
                "do{266} you know{1} (his name){264}?",
                "(how often){268} does{2} she [go{268} to, visit{268}] the{257} [cinema, movie theatre, movie theater, movies]?",
                "she [(does not drive){1}, (doesn't drive){1}, (never drives){1}, (can not){156} drive, (can't){156} drive, cannot{156} drive] a{250} car.",
            ]
            
        case .presentSimple_t_6:
            sentences = [
                "Зима наступает после осени.",
                "Мы никогда не смотрим это шоу.",
                "Кошки не любят собак.",
                "У него есть два брата.",
                "У меня нет автомобиля.",
            ]
            
            producers = [
                "/the winter [comes{3}, starts{3}] after /the [autumn, fall].",
                "we [never watch{2}, (do not watch){2}, (don't watch){2}] [this, that] show.",
                "cats{262} [(don't like){3}, (do not like){3}, dislike{3}, hate{3}] dogs{262}.",
                " [he has{1}, he (has got){1}, (he's got){1}] [two, 2] brothers{262}.",
                "i [(do not have){1}, (don't have){1}, (have not got){1}, (haven't got){1}] a{250} car.",
            ]
                
        case .presentContinuous_t_1:
            sentences = [
                "Сейчас она не спит, она готовит завтрак.",
                "Подожди минутку, я стараюсь вспомнить его имя.",
                "О чем он говорит?",
                "Сейчас она слушает музыку и убирает в квартире.",
                "Он в своей комнате, он играет в видео игры.",
            ]
            
            producers = [
                ">[now, at the moment, right now]{8} [(she's not sleeping){11}, she (is not sleeping){11}, she (isn't sleeping){11}] ><, [she (is cooking){11}, she (is preparing){11}, she (is making){11}, (she's cooking){11}, (she's preparing){11}, (she's making){11}] breakfast{265}.",
                " [wait{272}, wait{272} a minute], [I (am trying){11}, I'm trying{11}] to{201} [remember, recall, recollect] (his name){264}.",
                " [what{268} is{11}, what's{268}] he [talking{11}, speaking{11}] about?",
                " [/(at the moment), /now, /(right now)] [she (is listening){11}, she's listening{11}] to{246} music{263} and cleaning{1} [the{253}, her{264}] [flat, apartment] [/(at the moment), /now, /(right now)].",
                " [he's{197}, he is{197}] in (his room){264}, [he (is playing){8}, he's playing{8}] video games{262}.",
            ]
            
        case .presentContinuous_t_2:
            sentences = [
                "Где она? Она готовит ужин.",
                "Мы работаем над интересным проектом в настоящее время.",
                "Она ещё спит.",
                "Я сейчас занят, я говорю по телефону.",
                "Что ты сейчас делаешь?",
            ]
            
            producers = [
                " [where's{268}, where{268} is{197}] she? [she (is making){11}, (she's making){11}, she (is cooking){11}, she (is preparing){11}, (she's cooking){11}, (she's preparing){11}] dinner{265}.",
                ">>[nowadays, now, at present, these days, at the moment, right now]{8} [we (are working){12}, we're working{12}] on an{250} interesting project >><.",
                " [she is, she's] still<{9} sleeping{11}.",
                " [/now, /(at the moment)] [I am{197}, I'm{197}] busy, [(I'm speaking){11}, (I'm talking){11},(I am speaking){11}, (I am talking){11}] [by phone, by telephone, on the phone, on the telephone] [/now, /(at the moment)].",
                "what{266} are you doing{11} now{8}?",
            ]
            
        case .presentContinuous_t_3:
            sentences = [
                "Он ищет новую работу в настоящее время.",
                "Мы сейчас смотрим очень интересный сериал.",
                "Я в настоящее время не работаю.",
                "Становится все теплее с каждым днём.",
                "Все больше и больше людей путешествуют сейчас.",
            ]
            
            producers = [
                ">>[nowadays, now, at present, these days, at the moment]{8} [he is, he's] [(searching for){12}, (looking for){12}, (trying to){12} find] a{250} new job >><.",
                " [/now, /(at the moment), /(at present), /(these days)] [we (are watching){12}, we're watching{12}] [a{250} very{249} interesting  serial, very{249} interesting series{262}, a{250} very{249} interesting  show, very{249} interesting  serial] [/now, /(at the moment), /(at present), /(these days)].",
                ">>[now, at the moment, at present, these days]{8} [I'm not working{11}, I (am not working){11}] >><.",
                ">>[every day]{8} [it (is getting){13}, it (is becoming){13}, (it's getting){13}, (it's becoming){13}] [warmer{274}, (warmer and warmer){274}] >><.",
                ">>[now, at the moment, at present, these days, nowadays]{8} [more{280}, (more and more){280}] people{262} [(are traveling){13}, (are travelling){13}] >><.",
            ]
            
        case .presentContinuous_t_4:
               sentences = [
                   "Все меньше и меньше людей получают хорошую зарплату в наши дни.",
                   "Города становиться все больше с каждым годом.",
                   "Я сейчас сбрасываю вес.",
                   "Я завтра улетаю в Рим.",
                   "Мы встречаемся сегодня в баре в 6.",
               ]
               
               producers = [
                   ">>[now, at the moment, at present, these days, nowadays]{8} [(less and less){280}, less{280}] people{262} [(are getting){13}, (are receiving){13}] a{250} good [salary, pay] >><.",
                   ">>[every year]{8} cities{262} [(are getting){13}, (are becoming){13}] [bigger{274}, (much bigger){274}, (bigger and bigger){274}] >><.",
                   ">>[now, nowadays, at present, these days]{8} [(I'm losing){12}, (I'm trying){12} to lose, I (am losing){12}, I (am trying){12} to lose] weight{263} >><.",
                   ">>[tomorrow]{8} [I (am flying){14}, (I'm flying){14}] to{200} Rome{261} >><.",
                   ">>[today at 6, at 6 today, today at six, at six today] [we (are meeting){14}, (we're meeting){14}] in{220} the{257} bar >><.",
               ]
            
        case .presentContinuous_t_5:
            sentences = [
                "Она выходит замуж в след месяце.",
                "Они переезжают на новую квартиру в пятницу.",
                "Она постоянно меня перебивает!",
                "Мой босс постоянно кричит на меня!",
                "Он постоянно толкает меня!",
            ]
            
            producers = [
                ">>[next month]{8} [she (is getting){14} married, she's getting{14} married, she (is having){14} a{250} wedding, she's having{14} a{250} wedding] >><.",
                ">>[on Friday]{8} [they (are moving){14}, they're moving{14}] [into{200}, to{200}] a{250} new [flat, apartment] >><.",
                " [she is, she's] [constantly<{9}, always<{9}] interrupting{15} me!",
                "my{264} [boss is, chief is, superior is, boss's, chief's, superior's] [constantly<{9}, always<{9}] [screaming{15}, shouting{15}, yelling{15}] at me!",
                " [He is, he's] [constantly<{9}, always<{9}] pushing{15} me!",
            ]
            
        case .futureForm_1:
            sentences = [
                "Я сегодня встречаю своего брата в аэропорту в 5.",
                "Поторопись! Спектакль начнётся через 5 минут.",
                "Она бы хотела жить за границей.",
                "Они возможно спросят тебя об этом.",
                "Он планирует продать свой мотоцикл.",
            ]
            
            producers = [
                ">>[today at 5, at 5 today, today at five, at five today] [I am, I'm] meeting{14} (my brother){264} at{224} the{257} airport >><.",
                " [hurry{272}, (hurry up){272}]! the{253} [play, show, performance] [starts{4}, begins{4}] in{211} [5 minutes, five minutes, 5 min, five min].",
                " [she (would like to){59}, (she'd like to){59}] live abroad{204}.",
                "they [will{42} /probably, may{188}, might{188}] ask you about{238} [this, it, that].",
                " [he is, he's] [planning{12} to{201}, (going to){56}] sell [(his motorbike){264}, (his motorcycle){264}, (his bike){264}].",
            ]
            
        case .prepositionTo_1:
            sentences = [
                "Чтобы улучшить свой английский, тебе нужно заниматься каждый день.",
                "Я сейчас иду в магазин, чтобы купить вино.",
                "Она планирует улететь в Париж этим летом, чтобы увидеть Эйфелеву Башню.",
                "Я хотела бы увидеть его на следующей неделе.",
                "Моя сестра хочет переехать в новую квартиру в этом месяце.",
            ]
            
            producers = [
                "to{202} improve (your English){264}, you [need{1}, should] to{201} [study, practice] (every day){8}.",
                "/now [I (am going){11} to{200}, (I'm going){11} to{200}, I (am going){11} to{200} go, (I'm going){11} to{200} go]  the{257} [shop, store] to{202} buy /some wine{263} /now.",
                ">>[this summer]{8} [she (is planning){14} to{201}, (she's planning){14} to{201}, she (is going to){56}, (she's going to){56}] fly to{200} Paris{261} to{202} see the{260} Eiffel Tower >><.",
                ">>[next week]{8} [I (would like to){59}, (I'd like to){59}] see him >><. ",
                ">>[this month]{8} (my sister){264} wants{16} to{201} move to{200} a{250} new [flat, apartment] >><.",
            ]
            
        case .prepositionTo_2:
            sentences = [
                "Мы улетаем в Нью Йорк завтра, чтобы навестить наших друзей.",
                "Он ходит в спортзал 3 раза в неделю.",
                "Чтобы приготовить омлет, тебе нужно купить яйца и молоко.",
                "Хочешь пойти в парк с нами?",
                "Когда ты пойдёшь домой?",
            ]
            
            producers = [
                ">>[tomorrow]{8} [we (are flying){14}, (we're flying){14}] to{200} New York{261} to{202} [see, visit] (our friends){264} >><.",
                ">>[3 times a week, three times a week] he goes{2} to{200} the{257} gym >><.",
                "to{202} [make, prepare, cook] an{250} omelette, you need{1} to{201} [buy, purchase, get] /some eggs{262} and /some milk{263}.",
                " [do{266} you want{16}, (would you like){59}] to{202} go to{200} the{257} park with{240} us?",
                "when{268} [(will you go){42}, (are you going){56} to{201} go, are you planning to{201} go] home{204}?",
            ]
            
        case .aricles_1:
            sentences = [
                "Я хожу в спортзал 3 раза в неделю.",
                "Он ненавидит путешествовать поездом.",
                "Она живет на 2 этаже.",
                "Ты любишь апельсиновый сок?",
                "Я планирую съездить в США этим летом.",
            ]
            
            producers = [
                ">>[three times a week, 3 times a week] I go{2} to{200} the{257} gym >><.",
                "he [hates{1}, (does not like){1}, (doesn't like){1}, (can't stand){1}] travelling{151} by{237} train.",
                "she lives{1} on{229} the{256} [second, 2nd] floor.",
                "do{266} you [like{1}, love{1}] orange juice{263}?",
                ">>[this summer]{8} [I am, I'm] [planning{14} to{202}, (going to){56}] go to{200} the{258} [USA, United States, United States of America, us, US] >><.",
            ]
            
        case .aricles_2:
            sentences = [
                "Дэвид доктор, он работает в больнице.",
                "Я позвоню тебе утром.",
                "Эмма из Италии, итальянцы очень красивые.",
                "Мы обычно ездим в Испанию летом.",
                "Где дети? Они рисуют на кухне.",
            ]
            
            producers = [
                " [david is{197}, david's{197}] a{251} doctor, he works{1} in{220} the{257} hospital.",
                ">>[in the morning]{8} [I will call{42} you, I will phone{42} you, (I will call you up){42}, (I will ring you up){42}, I'll call{42} you, I'll phone{42} you, (I'll call you up){42}, (I'll ring you up){42}] >><.",
                " [emma is{197}, emma's{197}, emma comes{197}] from Italy{261}, the{258} Italians are{197} [very{249}, really{248}] [beautiful, pretty].",
                ">>[in the summer, in summer]{8} we usually<{9} [go{2}, travel{2}] to{200} Spain{261} >><.",
                "where{266} are{197} [our{264}, my{264}, the{254}] [children, kids]? they [(are drawing){11}, (are painting){11}] in{220} the{257} kitchen.",
            ]
            
        case .aricles_3:
            sentences = [
                "Скорпионы очень опасны.",
                "Давай поиграем в футбол.",
                "Она пишет новую книгу в настоящий момент.",
                "Это очень старый дом.",
                "Девушка на этой фотографии - моя сестра.",
            ]
            
            producers = [
                "scorpions{262} are{197} [very{249}, really{248}] dangerous.",
                " [let's{272}, (let us){272}] play football{261}.",
                ">>[nowadays, at present, these days, now]{8} [she (is writing){12}, (she's writing){12}] a{250} new book >><.",
                " [this, that] is{198} a{250} [very{249}, really{248}] old [house, building].",
                " [this, the{253}, that] girl in{220} [this, the{253}, that] [photo is{197}, photograph is{197}, picture is{197}, photo's{197}, photograph's{197}, picture's{197}] [my sister{264}, my sis{264}].",
            ]
            
        case .goldenRules:
            sentences = [
                "Ты знаешь его имя?",
                "Ты дома? Нет, я на работе.",
                "Я звоню своей маме каждую пятницу.",
                "Он часто ходит со своим сыном в кино.",
            ]
            
            producers = [
                "do{266} you know his name?",
                "are{197} you /at home? /No, [I am{197}, I'm{197}] [at{223} work, in{220} the{257} office, working].",
                ">>[every Friday, on Fridays]{8} I [call{2}, phone{2}] my [mom, mum, mother] >><.",
                "he often<{9} goes{2} to{200} the{257} [cinema, movies, movie theatre] with{240} his son.",
            ]
            
            
        case .toBe_1:
            sentences = [
                "Он не дома.",
                "Том сейчас в Лондоне.",
                "Она не занята.",
                "Где она?",
            ]
            
            producers = [
                " [He (is not){197}, He isn't{197}, He's{197} not] /at home.",
                "/now [Tom is{197}, Tom's{197}] in{221} London /now.",
                " [she's{197} not, she (is not){197}, she isn't{197}] [busy, occupied].",
                " [Where's{197}, Where is{197}] she?",
            ]
        case .toBe_2:
            sentences = [
                "Ты счастлив?",
                "Моя сестра сейчас не в офисе.",
                "Что это?",
                "Она замужем?",
            ]
            
            producers = [
                "are{197} you happy?",
                ">>[now, at the moment, right now]{8} my [sister (is not){197}, sister isn't{197}, sister's{197} not, sis (is not){197}, sis isn't{197}, sis's{197} not] in{220} the{257} office >><.",
                " [What's{198}, what is{198}] [this, that, it]?",
                "is{197} she married?",
            ]
        
        case .questions_1:
            sentences = [
                "Она живет в квартире?",
                "Мы встречаемся вечером?",
                "Они приедут к нам завтра?",
                "Ты поубираешь у себя в комнате?",
                "Он знает своё домашнее задание?",
            ]
            
            producers = [
                "does{266} she live{1} in{220} [a{250} flat, an{250} apartment]?",
                " [are{266} we meeting{14}, will{266} we meet{42}] in{205} the evening?",
                " [will{266} they come{42}, are{266} they coming{14}] to{200} us tomorrow?",
                " [will{266} you clean{42} (your room){264}, will{266} you clean{42} at your room, (are you going to){56} clean at your room, (are you going to){56} clean (your room){264}, (are you planning to){14} clean at your room, (are you planning to){14} clean (your room){264}]?",
                "does{266} he know{1} (his homework){264}?",
            ]
        
        case .questions_2:
            sentences = [
                "Почему она всегда грустная?",
                "Где он обычно завтракает?",
                "Как часто он звонит тебе?",
                "Сколько это стоит?",
                "Что ты делаешь?",
                "Разве она не знает об этом?",
            ]
            
            producers = [
                " [why{268} is{197}, why's{268}] she always{10} [sad, upset, gloomy]?",
                "where{268} does he usually<{9} [have{2}, eat{2}] breakfast{265}?",
                "(how often){268} does he [call{2}, phone{2}] you?",
                "(how much){268} [does it cost{1}, does this cost{1}, does that cost{1}, is{197} this, is{197} that, is{197} it]?",
                "what{268} are you doing{11}?",
                " [(does she not){267}, (doesn't she){267}] know{16} about{239} [it, this, that]?",
            ]
            
        case .questions_3:
            sentences = [
                "Ты любишь чай или кофе?",
                "Она приедет завтра или послезавтра?",
                "Он работает в офисе или на дому?",
                "Мы сегодня встречаемся в кафе или в баре?",
                "Вы будете покупать дом или снимать?",
            ]
            
            producers = [
                "do you like{16} tea{263} or{269} coffee{263}?",
                " [(will she come){42}, (is she coming){14}, (is she going){56} to come, (is she planning){14} to come] tomorrow or{269} the day after tomorrow?",
                "does he work{1} in{220} the{257} office or{269} from{241} home?",
                " [(will we meet){42}, (are we meeting){14}, (are we going){56} to meet, (are we planning){14} to meet] in{220} [a, the] cafe or{269} in{220} [a, the] bar today?",
                " [(will you buy){42} or{269} rent, (are you going to buy){56} or{269} rent, (are you planning){12} to buy or{269} rent, (are you planning){12} to buy or{269} rent] [a{250} house, it]?"
            ]
            
        case .questions_4:
            sentences = [
                "Завтра не будет дождя, не так ли?",
                "Ты не любишь футбол, не так ли?",
                "Она сейчас не спит, не так ли?",
                "Ты часто куришь, не так ли?",
                "Вы идёте сейчас в парк, не так ли?",
                
            ]
            
            producers = [
                " [tomorrow{8} it (will not rain){43} (will it){271}, tomorrow{8} it (won't rain){43} (will it){271}, tomorrow{8} (it's not going to){57} rain (is it){271}, tomorrow{8} it (is not going to){57} rain (is it){271}, it (will not rain){43} tomorrow{8} (will it){271}, it (won't rain){43} tomorrow{8} (will it){271}, (it's not going to){57} rain tomorrow{8} (is it){271}, it (is not going to){57} rain tomorrow{8} (is it){271}]?",
                "you [do not like{16}, don't like{16}, dislike{16}] [football, soccer], (do you){271}?",
                ">[now, at the moment]{8} [she (is not sleeping){11}, she (isn't sleeping){11}, (she's not sleeping){11}] ><, (is she){271}?",
                "you often<{9} smoke{2}, [(do you not){270}, (don't you){270}]?",
                " [(you are going){14}, (you're going){14}] to{200} the{257} park /now [(aren't you){270}, (are you not){270}]?",
            ]
            
        case .toBeGoingTo_1:
            sentences = [
                "Я планирую дописать свою книгу в след году.",
                "Она собирается идти спать.",
                "В котором часу мы планируем встретится завтра?",
                "Моя бабушка планирует навестить меня на выходных.",
            ]
            
            producers = [
                ">>[next year]{8} [(I am going to write){56}, (I am going to finish){56}, (I'm going to write){56}, (I'm going to finish){56}, I (am planning){14} to write, (I'm planning){14} to write] (my book){264} >><.",
                " [she (is going to go){56}, she's (going to go){56}, she (is planning){12} to go, (she's planning){12} to go] to{200} bed.",
                " [when{268}, (what time){268}] [(are we going to){56}, (are we planning){14} to] [meet{56}, see{56} each other] tomorrow?",
                ">>[on weekends, at the weekend]{8} [(my granny){264}, (my grandmother){264}] [(is going to){56}, (is planning){14} to] [come{56}, visit{56}] me >><.",
            ]
            
        case .toBeGoingTo_2:
           sentences = [
               "Он планирует приготовить пасту вечером.",
               "Посмотри на эту машину! Она сейчас врежется в это дерево.",
               "Осторожно! Ты сейчас разобьёшь эту вазу!",
               "Я планирую открыть свой бизнес.",
           ]
           
           producers = [
               ">>[in the evening]{8} [he (is going to){56}, he's (going to){56}, he (is planning){14} to, (he's planning){14} to] [make{57}, cook{57}, prepare{57}] pasta{263} >><.",
               "look{272} at{242} [this, that] car! [it (is going to){57}, (it's going to){57}] [break{57}, bump{57}, crash{57}] [into{200}, to{200}] [this, that] tree!",
               " [careful{272}, (be careful){272}]! you (are going to){57} [break{57}, crash{57}] [this, that] vase!",
               " [I (am going to){56}, (I'm going to){56}, I (am planning){12} to, (I'm planning){12} to] [open{56}, start{56}] [my, my own] business.",
           ]
            
        case .toBeGoingTo_3:
            sentences = [
                "Посмотри на небо! Сейчас точно пойдёт дождь.",
                "Мой отец планирует купить новую машину в этом году.",
                "Я не планирую приходить туда завтра.",
                "Она не планирует приглашать его на эту вечеринку.",
                "Ты планируешь рассказать ему об этом?",
            ]
            
            producers = [
                "look{272} at{242} the{260} sky! [it (is going to rain){57}, (it's going to rain){57}] /now!",
                ">>[this year]{8} my [father is, dad is, father's, dad's] [(going to buy){58}, (going to purchase){58}, planning{14} to buy] a{250} new car >><.",
                ">>[tomorrow]{8} [I am not, I'm not] [(going to go){58}, (going to come){58}, planning{14} to come] there >><.",
                " [she is not, she's not, she isn't] [(going to invite){56}, planning{14} to invite] him to{200} [this, that] party.",
                "are{266} you (going to tell){58} him about{238} [it, this, that]?",
            ]
            
        case .futureSimple_1:
            sentences = [
                "Я подготовлю эту презентацию завтра.",
                "В следующем году я пробегу марафон.",
                "Я не пойду в бассейн сегодня.",
                "Возможно они переедут в новую квартиру в этом году.",
                "Возможно мы получим эту посылку сегодня.",
            ]
            
            producers = [
                ">>[tomorrow]{8} [I will prepare{42}, I'll prepare{42}, I will finish{42}, I'll finish{42}] [this, the{253}, that] presentation >><.",
                ">>[next year]{8} [I (will run){42}, (I'll run){42}] [a{250}, this, that] marathon >><.",
                ">>[today]{8} [I (will not go){42}, I (won't go){42}, (I'll not go){42}] to{200} the{257} [swimming pool, pool] >><.",
                ">>[this year]{8} [they will{42}, they'll{42}] [probably<{9}, /probably] [(move to){42}, (move in){42}, (move into){42}] [a{250}, their] new [flat, apartment] >><.",
                ">>[today]{8} [we will{42}, we'll{42}] probably<{9} [get{42}, receive{42}] [this, the{253}, that] [delivery, parcel]>><.",
            ]
            
        case .futureSimple_2:
            sentences = [
                "Я больше никогда не буду врать!",
                "Я перезвоню тебе через 5 минут.",
                "Она поможет тебе после работы.",
                "Ее родители купят ей новую игрушку сегодня.",
                "Я приму решение завтра.",
            ]
            
            producers = [
                " [I will{44}, I'll{44}] never<{9} [lie{44}, (tell lies){44}] /again.",
                ">>[in five minutes, in 5 minutes, in 5 min] [I will{44}, I'll{44}] [call{44} you, call{44} you back, return{44} your call] >><.",
                ">>[after work]{8} [she (will help){44}, (she'll help){44}] you >><.",
                ">>[today]{8} her parents (will buy){44} her a{250} new toy >><.",
                ">>[tomorrow]{8} [I'll{44}, I will{44}] [decide{44}, make{44} a{250} decision, take{44} a{250} decision, make{44} my decision{264}, make this decision, make that decision, take this decison, take that decision, make this decision, make that decision] >><.",
            ]
            
        case .futureSimple_3:
            sentences = [
                "Я никогда тебя не прощу.",
                "Она напишет письмо тебе послезавтра.",
                "Она не будет с тобой разговаривать.",
                "Я уверен, они не приедут.",
                "Эта блузка стоит всего 15 долларов, я куплю ее.",
            ]
            
            producers = [
                " [I'll{44}, I will{44}] never<{9} forgive{44} you.",
                ">>[the day after tomorrow]{8} [she will{42}, she'll{42}] [write{42} you a{250} letter, write{42} a{250} letter to you] >><.",
                " [she (will not){43}, (she'll not){43}, she won't{43}] [(talk to){43}, (speak to){43}, (speak with){43}] you.",
                " [I'm{197} sure, I'm{197} confident, I'm{197} convinced, I am{197} sure, I am{197} confident, I am{197} convinced, I believe{16}] [they (will not){43}, they won't{43}, (they'll not){43}] come{43}.",
                " [this, that] [blouse costs{16}, blouse is{197}, blouse's{197}] [/just, /only] [15 dollars, fifteen dollars, 15$], [I (will buy){45}, (I'll buy){45}] it."
            ]
            
        case .futureSimple_4:
            sentences = [
                "Я уверен, он споёт эту песню сегодня.",
                "Он расскажет тебе все позже.",
                "Не переживай, я заплачу за тебя.",
                "Однажды я стану известным актером.",
            ]
            
            producers = [
                ">>[today]{8} [I'm{197}, I am{197}] [sure, confident, convinced], [he (will sing){43}, (he'll sing){43}] [this, that, the{253}] song >><.",
                " [he (will tell){44}, (he'll tell){44}] you everything later.",
                 " [(do not worry){273}, (don't worry){273}, no worries]! [I (will pay){45}, (I'll pay){45}] for you.",
                ">>[one day]{8} [(I will be){43}, (I'll be){43}, (I will become){43}, (I'll become){43}] a{251} famous actor >><.",
            ]
            
        case .prepositionOfTime_1:
            sentences = [
                "В котором часу ты просыпаешься утром?",
                "Что она любит делать по выходным?",
                "Мой день рождение 3 января.",
                "Поторопись! Твой поезд уезжает через 20 минут.",
            ]
            
            producers = [
                " [(what time){268}, when{268}] do you [(wake up){2}, (get up){2}] in{205} the morning?",
                "what{268} does she like{1} doing{151} [(on weekends){218}, (at the weekend){214}]?",
                " [(my birthday){264} is{197}, my birthday's{197}] [on{217} the third of January, on{217} the 3rd of January, on{217} January the third, on{217} January the 3rd].",
                " [hurry{272}, (hurry up){272}]! [the{253}, your{264}] train [leaves{4}, departs{4}] in{211} [twenty, 20, twony] [min, minutes]."
            ]
            
        case .prepositionOfTime_2:
            sentences = [
                "Они всегда ходят в парк на выходных.",
                "Я планирую уйти в отпуск в июле.",
                "Давай встретимся в пятницу вечером.",
                "На рождество мы планируем навестить наших родственников.",
                "Фермеры обычно просыпаются на рассвете.",
            ]
            
            producers = [
                ">>[on weekends, at the weekend]{8} they always<{9} go{2} to{200} the{257} park >><.",
                ">>[in July]{8} [I (am planning){14} to, (I'm planning){14} to, (I'm going to){56}, I (am going to){56}] go on{203} [holiday, holidays, vacation] >><.",
                " [(let us){272}, let's{272}] [meet, see each other, have a{250} meeting] [on{216} Friday evening, on{215} Friday in{205} the evening, in{205} the evening on{215} Friday].",
                ">>[at Christmas, on Christmas Day]{8} [we (are planning){14} to{201}, (we're planning){14} to{201}, (we are going to){56}, (we're going to){56}] [visit (our relatives){264}, visit (our family){264}, give (our relatives){264} a visit, give (our family){264} a visit] >><.",
                "Farmers{262} usually<{9} [(wake up){2}, (get up){2}] at{214} [sunrise, dawn]."
            ]
            
        case .prepositionOfTime_3:
            sentences = [
                "Они планируют съездить в Италию в мае.",
                "Мы обсуждаем этот вопрос в настоящий момент.",
                "Мой кот никогда не спит ночью.",
                "Я улетаю в Китай на этой неделе в субботу.",
                "Мы планируем сходить в кино в воскресенье вечером.",
            ]
            
            producers = [
                ">>[in May]{8} [they (are planning){14} to{201}, they're planning{14} to{201}, (they are going to){56}, (they're going to){56}] [go, travel] to{200} Italy{261} >><.",
                ">>[now, at the moment, right now]{8} [we (are discussing){11}, (we're discussing){11}, we (are talking){11} about{238}, (we're talking){11} about{238}] [this, that] question >><.",
                ">>[at night]{8} (my cat){264} never<{9} sleeps{1} >><.",
                ">>[this week on Saturday, on Saturday this week, this Saturday]{8} [I (am flying){14}, (I'm flying){14}, I (am going){14}, (I'm going){14}, I (am travelling){14}, (I'm travelling){14}, I (am traveling){14}, (I'm traveling){14}] to{200} China >><.",
                ">>[on Sunday in the evening, on Sunday evening, in the evening on Sunday]{8} [(we are going to){56}, (we're going to){56}, we (are planning){14} to{201}, (we're planning){14} to{201}] go to{200} the{257} [cinema, movies, movie theatre, movie theater] >><."
            ]
            
        case .prepositionOfTime_4:
            sentences = [
                "Она звонит маме каждую среду.",
//                "Она планирует открыть новый магазин 20 октября.",
                "Последний поезд в Берлин отходит в полночь.",
                "На пасху мы обычно едим яйца.",
            ]
            
            producers = [
                ">>[every Wednesday]{8} she [calls{2}, phones{2}] [(her mother){264}, (her mom){264}, (her mum){264}] >><.",
//                ">>[on the 20th of October, on the twentieth of October, on October the 20th, on October the twentieth, on 20th October, on October 20th] [she (is planning){14} to{201}, (she's planning){14} to{201}, she (is going to){56}, (she's going to){56}] open a{250} new [shop, store] >><.",
                "the{253} last train to{200} Berlin [is{197}, leaves{4}, departs{4}] at{212} midnight.",
                ">>[at Easter]{8} we usually<{9} eat{2} eggs >><.",
            ]
            
        case .prepositionOfPlace_1:
            sentences = [
                "Посмотри на них, они плавают в речке.",
                "Ночью ты сможешь увидеть звёзды на небе.",
                "Мы часто проводим наш отпуск в Италии.",
                "Я жду тебя на автобусной остановке.",
                "Мой брат живет в маленьком селе",
                "Они сегодня на работе?",
                
            ]
            
            producers = [
                " [(Look at them){272}, (have a look){272}] [they (are swimming){11}, (they‘re swimming){11}] in{220} the{259} river.",
                ">>[at night]{8} you can{169} see (the stars){260} in{220} (the sky){260}>><.",
                "We often<{9} spend{2} our [holiday, vacation] in{220} Italy",
                " [(I'm waiting){11}, I (am waiting){11}] for{245} you at{224} the{257} bus stop.",
                "My brother lives{1} in{220} a{250} [small, little] village.",
                "Are{197} they at{223} work today?",
            ]
            
        case .prepositionOfPlace_2:
            sentences = [
                "Ему нравится эта картина на стене.",
                "Где она? Она на кухне.",
                "Я часто слушаю эту песню по радио.",
                "Она встретит тебя в аэропорту в 5.",
                "Поверни на лево на светофору.",
                "Она сейчас в школе.",
            ]
            
            producers = [
                "He likes{16} [this, the{253}, that] [picture, painting] on{229} the wall{253}.",
                " [where's{268}, (where is){268}] she? [she's{197}, she is{197}] in{220} the{257} kitchen.",
                "I often<{9} listen{2} to{246} this song on{231} the{260} radio.",
                ">>[at 5, at five, at 5 o'clock, at five o'clock] [(she's meeting){14}, she (is meeting){14}, (she's going to meet){58}, she (is going to meet){58}] you at{224} the{257} airport >><.",
                " [(Turn left){272}, (take a left turn){272}] at{224} the{257} traffic lights.",
                "/now [she is{197}, she's{197}] at{223} school /now.",
            ]
            
        case .prepositionOfPlace_3:
            sentences = [
                "Она мечтает купить себе дом возле моря.",
                "Ответ внизу страницы.",
                "Кот сейчас спит на диване.",
                "Где он? Он в клубе на каком-то концерте.",
                "Он сейчас в командировке.",
            ]
            
            producers = [
                " [she dreams{1}, (she's dreaming){12}, she (is dreaming){12}] to{201} buy a{250} house [near, at{226}] the{259} sea.",
                "The [answer is{197}, answer's{197}] (at the bottom){228} of{280} the page.",
                "The{253} [(cat's sleeping){11}, cat (is sleeping){11}] on{229} the{253} [couch, sofa].",
                " [where's{268}, where{268} is{197}] he? [he's{197}, he is{197}] in{220} the{257} club at{225} [some, a{250}] concert.",
                " [he is{197}, he's{197}] on{203} a{250} business trip.",
            ]
            
        case .conditionalType_1:
            sentences = [
                "Если ты голоден, я приготовлю что-то покушать.",
                "Если она будет усердно учиться, она сдаст экзамены.",
                "Я помогу тебе, если ты попросишь.",
                "Я пойду на эту вечеринку, если он меня пригласит.",
                "Если он не позвонит, я не расскажу ему об этом.",
            ]
            
            producers = [
                "if [you are{197}, you're{197}] hungry{111}, [I (will cook){111}, I (will make){111}, I (will prepare){111}, (I'll cook){111}, (I'll make){111}, (I'll prepare){111}] something [/to eat, ].",
                "if she [studies{111}, works{111}] [hard, a lot], [she (will pass){111}, (she'll pass){111}] [her exams{264}, her examination{264}]",
                " [I (will help){111} you, I (will help){111} you out, I (will give){111} you a hand, (I'll help){111} you, (I'll help){111} you out, (I'll will give){111} you a hand] if you ask{111} me.",
                " [I (will go){111}, I (will come){111}, (I'll go){111}, (I'll come){111}] to{200} [the{253}, this, that] party, if he invites{111} me.",
                " [if he (doesn't call){111}, if (he does not call){111}, unless he calls{111}] me, [I (will not tell){111}, (I'll not tell){111}, I (won't tell){111}] him about{238} [it, this, that].",
            ]
            
        case .IntroStory_fake:
            sentences = [
                "Он пьёт кофе каждый день.",
            ]
            
            producers = [
                ">>[every day]{8} he [drinks{2}, has{2}] [coffee{263}, (some coffee){263}, a<{250} cup of coffee] >><.",
            ]
            
        case .Goodlife_item_remote:
            sentences = [
                "Он пьёт кофе каждый день.",
            ]
            
            producers = [
               ">>[every day]{8} he [drinks{2}, has{2}] [coffee{263}, (some coffee){263}, a<{250} cup of coffee] >><.",
            ]
            
        case .GoodLife_item_circle:
           sentences = [
                "Мой брат не знает китайский.",
                "Ты знаешь его имя?",
                
                
           ]
           
           producers = [
               "my brother [(does not){1}, doesn't{1}] [know{1}, speak{1}] Chinese.",
               "do{266} you know{1} (his name){264}?",
               
           ]
            
        case .GoodLife_Home_item_router:
            sentences = [
                "Она не водит машину.",
                "Мы работаем над интересным проектом в настоящее время.",
            ]
            
            producers = [
                "she [(does not drive){1}, (doesn't drive){1}, (never drives){1}, (can not){156} drive, (can't){156} drive, cannot{156} drive] a{250} car.",
                 ">>[nowadays, now, at present, these days, at the moment, right now]{8} [we (are working){12}, we're working{12}] on an{250} interesting project >><.",
            ]   
            
        case .Supermarket_item_cookies:
            sentences = [
                "Том сейчас в Лондоне.",
                "Мой самолёт прилетает в 7.",
                "Подожди минутку, я стараюсь вспомнить его имя.",
            ]
            
            producers = [
                "/now [Tom is{197}, Tom's{197}] in{221} London /now.",
                ">>[at seven, at seven o'clock, at 7, at 7 o'clock] my [airplane, plane] [comes{4}, arrives{4}, lands{4}] >><.",
                " [wait{272}, wait{272} a minute], [I (am trying){11}, I'm trying{11}] to{201} [remember, recall, recollect] (his name){264}.",
                
            ]
            
        case .Supermarket_item_key:
            sentences = [
                "Моя сестра сейчас не в офисе.",
                "Города становиться все больше с каждым годом.",
                "Они часто навещают нас.",
            ]
            
            producers = [
                ">>[now, at the moment, right now, at present]{8} my [sister (is not){197}, sister isn't{197}, sister's{197} not, sis (is not){197}, sis isn't{197}, sis's{197} not] in{220} the{257} office >><.",
                ">>[every year]{8} cities{262} [(are getting){13}, (are becoming){13}] [bigger{274}, (much bigger){274}, (bigger and bigger){274}] >><.",
                "they often<{9} [visit{2}, come{2} to{200}] us.",
                
            ]
         
            
        case .Supermarket_item_cashdesk:
            sentences = [
               "Почему она редко звонит нам?",
               "Мы сейчас смотрим очень интересный сериал.",
               "Они переезжают на новую квартиру в пятницу.",
                
            ]
            
            producers = [
                "why{268} does{2} she [rarely<{9}, seldom<{9}] [call{268}, phone{268}] us?",
                " [/now, /(at the moment), /(at present), /(these days)] [we (are watching){12}, we're watching{12}] [a{250} very{249} interesting  serial, very{249} interesting series{262}, a{250} very{249} interesting  show, very{249} interesting  serial] [/now, /(at the moment), /(at present), /(these days)].",
                ">>[on Friday]{8} [they (are moving){14}, they're moving{14}] [into{200}, to{200}] a{250} new [flat, apartment] >><.",
            ]
            
            
        case .Library_street_item_card:
            sentences = [
                "Я сегодня встречаю своего брата в аэропорту в 5.",
                "Он часто ходит со своим сыном в кино.",
                "Дельфины живут в воде.",
                
            ]
            
            producers = [
                ">>[today at 5, at 5 today, today at five, at five today] [I am, I'm] meeting{14} (my brother){264} at{224} the{257} airport >><.",
                "he often<{9} goes{2} to{200} the{257} [cinema, movies, movie theatre] with{240} his son.",
                "dolphins live{3} in{220} water{263}.",
            ]
            
        case .Library_street_item_duck:
            sentences = [
                 "Где она живет?",
                 "Она ещё спит.",
            ]
            
            producers = [
                "where{268} does{1} she live{268}?",
                " [she is, she's] still<{9} sleeping{11}.",
            ]
            
        case .Library_book_item_password:
            sentences = [
                "Она постоянно меня перебивает!",
                "Он редко приглашает в кино свою девушку.",
                "Где она?",
                "Я завтра улетаю в Рим.",
            ]
            
            producers = [
                " [she is, she's] [constantly<{9}, always<{9}] interrupting{15} me!",
                "he rarely<{9} invites{2} his girlfriend to{200} the{257} [cinema, movies, movie theatre, movie theatre].",
                " [Where's{197}, Where is{197}] she?",
                ">>[tomorrow]{8} [I (am flying){14}, (I'm flying){14}] to{200} Rome{261} >><.",
            ]
            
        case .Library_computer_item_secondLevelCard:
            sentences = [
                "Нам не нравится этот фильм.",
                "Каждое утро я езжу на работу на метро.",
                "Становится все теплее с каждым днём.",
                "Я хотела бы увидеть его на следующей неделе.",
                "Я в настоящее время не работаю.",
            ]
            
            producers = [
                 "we [(do not like){1}, (don't like)){1}, dislike{1}] [this, that] [film, movie].",
                 ">>[every morning]{8} I go{2} to{200} work{263} by{237} [metro, subway, underground] >><.",
                ">>[every day]{8} [it (is getting){13}, it (is becoming){13}, (it's getting){13}, (it's becoming){13}] [warmer{274}, (warmer and warmer){274}] >><.",
                ">>[next week]{8} [I (would like to){59}, (I'd like to){59}] see him >><. ",
                ">>[now, at the moment, at present, these days]{8} [I'm not working{11}, I (am not working){11}] >><.",
            ]
            
        case .Library_computer_item_sandwich:
            sentences = [
                "Что это означает?",
                "Мы никогда не смотрим это шоу.",
                "Все больше и больше людей путешествуют сейчас.",
            ]
            
            producers = [
                "what{268} does{1} [it, this, that] mean{268}?",
                "we [never watch{2}, (do not watch){2}, (don't watch){2}] [this, that] show.",
                ">>[now, at the moment, at present, these days, nowadays]{8} [more{280}, (more and more){280}] people{262} [(are traveling){13}, (are travelling){13}] >><.",
            ]
            
        case .Library_server_item_checkWithName:
            sentences = [
                "Я планирую съездить в США этим летом.",
                "Ты знаешь его имя?",
                "Я убираю свою квартиру каждую пятницу.",
            ]
            
            producers = [
                ">>[this summer]{8} [I am, I'm] [planning{14} to{202}, (going to){56}] go to{200} the{258} [USA, United States, United States of America, us, US] >><.",
                "do{266} you know his name?",
                ">>[every Friday, on Friday, on Fridays]{8} I clean{2} [(my flat){264}, (my apartment){264}] >><.",
            ]
            
        case .Library_server_item_hackedServer:
            sentences = [
                "О чем он говорит?",
                "Эмма из Италии, итальянцы очень красивые.",
                "Они приедут к нам завтра?",
                "Он сейчас не спит, не так ли?",
            ]
            
            producers = [
                 " [what{268} is{11}, what's{268}] he [talking{11}, speaking{11}] about?",
                 " [emma is{197}, emma's{197}, emma comes{197}] from Italy{261}, the{258} Italians are{197} [very{249}, really{248}] [beautiful, pretty].",
                 " [will{266} they come{42}, are{266} they coming{14}] to{200} us tomorrow?",
                 ">[now, at the moment]{8} he [(is not sleeping){11}, (isn't sleeping){11}] ><, (is he){271}?",
            ]

        case .Library_server_item_desk:
            sentences = [
               "Я хожу в спортзал 3 раза в неделю.",
               "Я сейчас занят, я говорю по телефону.",
               "Как часто она ходит в кино?",
               "Мой начальник обожает спорт.",
            ]
            
            producers = [
               ">>[three times a week, 3 times a week] I go{2} to{200} the{257} gym >><.",
               " [/now, /(at the moment)] [I am{197}, I'm{197}] busy, [(I'm speaking){11}, (I'm talking){11},(I am speaking){11}, (I am talking){11}] [by phone, by telephone, on the phone, on the telephone] [/now, /(at the moment)].",
               "(how often){268} does{2} she [go{268}, visit{268}] the{257} [cinema, movie theatre, movie theater, movies]?",
                "my [boss, chief] [likes{1} sport{263}, likes{1} sport{263} very much, loves{1} sport{263} very much, loves{1} sport{263}, really{248} loves{1} sport{263}, absolutely loves{1} sport{263}].",
            ]
        
        case .JDHome_item_router:
            sentences = [
                 "Она делает домашнее задание по вечерам.",
                 "Она живет на 2 этаже.",
                 "Мы встречаемся вечером?",
            ]
            
            producers = [
                ">>[in the evening, in the evenings]{8} she does{2} /her homework >><.",
                "she lives{1} on{229} the{256} [second, 2nd] floor.",
                " [are{266} we meeting{14}, will{266} we meet{42}] in{205} the evening?",
            ]
            
        case .JDHome_item_profile_1:
            sentences = [
                    "Я позвоню тебе утром.",
                    "Я звоню своей маме каждую пятницу.",
                    "Он работает в офисе или на дому?",
                    "Она пишет новую книгу в настоящий момент.",
                   
                ]
                
                producers = [
                    ">>[in the morning]{8} [I will call{42} you, I will phone{42} you, (I will call you up){42}, (I will ring you up){42}, I'll call{42} you, I'll phone{42} you, (I'll call you up){42}, (I'll ring you up){42}] >><.",
                    ">>[every Friday, on Fridays]{8} I [call{2}, phone{2}] my [mom, mum, mother] >><.",
                    "does he work{1} in{220} the{257} office or{269} from{241} home?",
                    ">>[nowadays, at present, these days, now]{8} [she (is writing){12}, (she's writing){12}] a{250} new book >><.",
                ]
        
        case .JDHome_item_profile_2:
            sentences = [
                    "Как часто он звонит тебе?",
                    "Что это?",
                    "Мы обычно ездим в Испанию летом.",
                    "Чтобы приготовить омлет, тебе нужно купить яйца и молоко.",
                ]
                
                producers = [
                    "(how often){268} does he [call{2}, phone{2}] you?",
                    " [What's{198}, what is{198}] [this, that, it]?",
                    ">>[in the summer, in summer]{8} we usually<{9} [go{2}, travel{2}] to{200} Spain{261} >><.",
                    "to{202} [make, prepare, cook] an{250} omelette, you need{1} to{201} [buy, purchase, get] /some eggs{262} and /some milk{263}.",
                ]
        
        case .JDHome_item_profile_3:
            sentences = [
                    "В котором часу мы планируем встретится завтра?",
                    "Давай поиграем в футбол.",
                    "Она выходит замуж в след месяце.",
                    "Кошки не любят собак.",
                ]
                
                producers = [
                    " [when{268}, (what time){268}] [(are we going to){56}, (are we planning){14} to] [meet{56}, see{56} each other] tomorrow?",
                    " [let's{272}, (let us){272}] play football{261}.",
                    ">>[next month]{8} [she (is getting){14} married, she's getting{14} married, she (is having){14} a{250} wedding, she's having{14} a{250} wedding] >><.",
                    "cats{262} [(don't like){3}, (do not like){3}, dislike{3}, hate{3}] dogs{262}.",
                ]
        
        case .JDHome_item_profile_4:
            sentences = [
                    "Хочешь пойти в парк с нами?",
                    "Она замужем?",
                    "Вы будете покупать дом или снимать?",
                    "Ты любишь апельсиновый сок?",
                ]
                
                producers = [
                     " [do{266} you want{16}, (would you like){59}] to{202} go to{200} the{257} park with{240} us?",
                     "is{197} she married?",
                     " [(will you buy){42} or{269} rent, (are you going to buy){56} or{269} rent, (are you planning){12} to buy or{269} rent, (are you planning){12} to buy or{269} rent] [a{250} house, it]?",
                     "do{266} you [like{1}, love{1}] orange juice{263}?",
                ]   
        
        
        case .ScientistHome_item_doorBell:
        sentences = [
                    "Ты дома? Нет, я на работе.",
                    "Он не дома.",
                ]
                
                producers = [
                     "are{197} you /at home? /No, [I am{197}, I'm{197}] [at{223} work, in{220} the{257} office, working].",
                     " [He (is not){197}, He isn't{197}, He's{197} not] /at home.",
                ]
        
    
        case .ScientistHome_item_picture:
            sentences = [
                 "Я сейчас сбрасываю вес.",
                 "У меня нет автомобиля.",
                 "Мы иногда остаёмся дома на выходных.",
            ]
            
            producers = [
                ">>[now, nowadays, at present, these days]{8} [(I'm losing){12}, (I'm trying){12} to lose, I (am losing){12}, I (am trying){12} to lose] weight{263} >><.",
                "i [(do not have){1}, (don't have){1}, (have not got){1}, (haven't got){1}] a{250} car.",
                ">>[at the weekend, on weekends]{8} we sometimes<{9} stay{2} /home >><.",
            ]
    
        
        case .ScientistHome_item_notepad:
            sentences = [
                     "Девушка на этой фотографии - моя сестра.",
                     "Мы сегодня встречаемся в кафе или в баре?",
                     "Вы идёте сейчас в парк, не так ли?",
                ]
                
                producers = [
                    " [this, the{253}, that] girl in{220} [this, the{253}, that] [photo is{197}, photograph is{197}, picture is{197}, photo's{197}, photograph's{197}, picture's{197}] [my sister{264}, my sis{264}].",
                    " [(will we meet){42}, (are we meeting){14}, (are we going){56} to meet, (are we planning){14} to meet] in{220} [a, the] cafe or{269} in{220} [a, the] bar today?",
                    " [(you are going){14}, (you're going){14}] to{200} the{257} park /now [(aren't you){270}, (are you not){270}]?",
                ]
            
        case .ScientistHome_item_liPaseCard:
            sentences = [
                "Дэвид доктор, он работает в больнице.",
                "Он ищет новую работу в настоящее время.",
                "Он редко курит.",
            ]
            
            producers = [
                " [david is{197}, david's{197}] a{251} doctor, he works{1} in{220} the{257} hospital.",
                ">>[nowadays, now, at present, these days, at the moment]{8} [he is, he's] [(searching for){12}, (looking for){12}, (trying to){12} find] a{250} new job >><.",
                "he [rarely<{9}, seldom<{9}] smokes{2}.",
                
            ]
            
        case .ScientistHome_item_closedRoom:
            sentences = [
                "Он знает своё домашнее задание?",
                "Я планирую уйти в отпуск в июле.",
            ]
            
            producers = [
                "does{266} he know{1} (his homework){264}?",
                ">>[in July]{8} [I (am planning){14} to, (I'm planning){14} to, (I'm going to){56}, I (am going to){56}] go on{203} [holiday, holidays, vacation] >><.",
            ]
            
        case .ScientistHome_item_liPaseComputer:
            sentences = [
                "Он ненавидит путешествовать поездом.",
                "Чтобы улучшить свой английский, тебе нужно заниматься каждый день.",
                "Все меньше и меньше людей получают хорошую зарплату в наши дни.",
           ]
                       
           producers = [
               "he [hates{1}, (does not like){1}, (doesn't like){1}, (can't stand){1}] travelling{151} by{237} train.",
               "to{202} improve (your English){264}, you [need{1}, should] to{201} [study, practice] (every day){8}.",
               ">>[now, at the moment, at present, these days, nowadays]{8} [(less and less){280}, less{280}] people{262} [(are getting){13}, (are receiving){13}] a{250} good [salary, pay] >><.",
           ]
            
        case .ScientistHome_item_sunflower_1:
            sentences = [
                "Ты часто куришь, не так ли?",
            ]
            
            producers = [
                "you often<{9} smoke{2}, [(do you not){270}, (don't you){270}]?",
            ]
            
        case .ScientistHome_item_sunflower_2:
            sentences = [
//                "Она планирует открыть новый магазин 20 октября.",
                "Мы улетаем в Нью Йорк завтра, чтобы навестить наших друзей.",
            ]
            
            producers = [
//                ">>[on the 20th of October, on the twentieth of October, on October the 20th, on October the twentieth, on 20th October, on October 20th] [she (is planning){14} to{201}, (she's planning){14} to{201}, she (is going to){56}, (she's going to){56}] open a{250} new [shop, store] >><.",
                ">>[tomorrow]{8} [we (are flying){14}, (we're flying){14}] to{200} New York{261} to{202} [see, visit] (our friends){264} >><.",
            ]
            
        case .ScientistHome_item_sunflower_3:
            sentences = [
                "Однажды я стану известным актером.",
            ]
            
            producers = [
                ">>[one day]{8} [(I will be){43}, (I'll be){43}, (I will become){43}, (I'll become){43}] a{251} famous actor >><.",
            ]
            
        case .ScientistHome_item_sunflower_4:
            sentences = [
                "Разве она не знает об этом?",
            ]
            
            producers = [
                " [(does she not){267}, (doesn't she){267}] know{16} about{239} [it, this, that]?",
            ]
            
        case .ScientistHome_item_sunflower_5:
            sentences = [
                "Возможно мы получим эту посылку сегодня.",
            ]
            
            producers = [
                ">>[today]{8} [we will{42}, we'll{42}] probably<{9} [get{42}, receive{42}] [this, the{253}, that] [delivery, parcel]>><.",
            ]
            
        case .ScientistHome_item_sunflower_6:
            sentences = [
                "Не переживай, я заплачу за тебя.",
            ]
            
            producers = [
                " [(do not worry){273}, (don't worry){273}, no worries]! [I (will pay){45}, (I'll pay){45}] for you.",
            ]
            
        case .ScientistHome_item_carrot_1:
            sentences = [
                "Я убираю свою квартиру каждую пятницу.",
            ]
            
            producers = [
                ">>[every Friday, on Friday, on Fridays]{8} I clean{2} [(my flat){264}, (my apartment){264}] >><.",
            ]
            
        case . ScientistHome_item_carrot_2:
            sentences = [
                "Мы встречаемся вечером?",
            ]
            
            producers = [
                " [are{266} we meeting{14}, will{266} we meet{42}] in{205} the evening?",
            ]
            
        case .ScientistHome_item_carrot_3:
            sentences = [
                "Она живет на 2 этаже.",
            ]
            
            producers = [
                "she lives{1} on{229} the{256} [second, 2nd] floor.",
            ]
            
        case .ScientistHome_item_carrot_4:
            sentences = [
                "Она делает домашнее задание по вечерам.",
            ]
            
            producers = [
                 ">>[in the evening, in the evenings]{8} she does{2} /her homework >><.",
            ]
            
        case .ScientistHome_item_carrot_5:
            sentences = [
                "Мой начальник обожает спорт.",
            ]
            
            producers = [
                "my [boss, chief] [likes{1} sport{263}, likes{1} sport{263} very much, loves{1} sport{263} very much, loves{1} sport{263}, really{248} loves{1} sport{263}, absolutely loves{1} sport{263}].",
            ]
            
        case .ScientistHome_item_carrot_6:
            sentences = [
                "Как часто она ходит в кино?",
            ]
            
            producers = [
                "(how often){268} does{2} she [go{268}, visit{268}] the{257} [cinema, movie theatre, movie theater, movies]?",
            ]
            
        case .ScientistHome_item_carrot_7:
            sentences = [
                "Я сейчас занят, я говорю по телефону.",
            ]
            
            producers = [
                " [/now, /(at the moment)] [I am{197}, I'm{197}] busy, [(I'm speaking){11}, (I'm talking){11},(I am speaking){11}, (I am talking){11}] [by phone, by telephone, on the phone, on the telephone] [/now, /(at the moment)].",
            ]
            
        case .ScientistHome_item_carrot_8:
            sentences = [
                "Он сейчас не спит, не так ли?",
            ]
            
            producers = [
                 ">[now, at the moment]{8} he [(is not sleeping){11}, (isn't sleeping){11}] ><, (is he){271}?",
            ]
            
        case .ScientistHome_item_beet_1:
            sentences = [
                "Ты знаешь его имя?",
            ]
            
            producers = [
                "do{266} you know his name?",
            ]
            
        case .ScientistHome_item_beet_2:
            sentences = [
                "Я планирую съездить в США этим летом.",
            ]
            
            producers = [
                ">>[this summer]{8} [I am, I'm] [planning{14} to{202}, (going to){56}] go to{200} the{258} [USA, United States, United States of America, us, US] >><.",
            ]
            
        case .ScientistHome_item_beet_3:
            sentences = [
                "Она планирует улететь в Париж этим летом, чтобы увидеть Эйфелеву Башню.",
            ]
            
            producers = [
               ">>[this summer]{8} [she (is planning){14} to{201}, (she's planning){14} to{201}, she (is going to){56}, (she's going to){56}] fly to{200} Paris{261} to{202} see the{260} Eiffel Tower >><.",
            ]
            
        case .ScientistHome_item_beet_4:
            sentences = [
                "Они приедут к нам завтра?",
            ]
            
            producers = [
                " [will{266} they come{42}, are{266} they coming{14}] to{200} us tomorrow?",
            ]
            
        case .ScientistHome_item_beet_5:
            sentences = [
                "Я хожу в спортзал 3 раза в неделю.",
            ]
            
            producers = [
                ">>[three times a week, 3 times a week] I go{2} to{200} the{257} gym >><.",
            ]
            
        case .ScientistHome_item_beet_6:
            sentences = [
                "О чем он говорит?",
            ]
            
            producers = [
                " [what{268} is{11}, what's{268}] he [talking{11}, speaking{11}] about?",
            ]
            
        case .ScientistHome_item_beet_7:
            sentences = [
                "Мы работаем над интересным проектом в настоящее время.",
            ]
            
            producers = [
                ">>[nowadays, now, at present, these days, at the moment]{8} [we (are working){12}, we're working{12}] on an{250} interesting project >><.",
            ]
            
        case .ScientistHome_item_beet_8:
            sentences = [
                "Мой брат не знает китайский.",
            ]
            
            producers = [
                 "my brother [(does not){1}, doesn't{1}] [know{1}, speak{1}] Chinese.",
            ]
            
        case .ScientistHome_item_beet_9:
            sentences = [
                "Подожди минутку, я стараюсь вспомнить его имя.",
            ]
            
            producers = [
                " [wait{272}, wait{272} a minute], [I (am trying){11}, I'm trying{11}] to{201} [remember, recall, recollect] (his name){264}.",
            ]
            
        case .ScientistHome_item_beet_10:
            sentences = [
                "Сейчас она не спит, она готовит завтрак.",
            ]
            
            producers = [
                ">[now, at the moment, right now]{8} [(she's not sleeping){11}, she (is not sleeping){11}, she (isn't sleeping){11}] ><, [she (is cooking){11}, she (is preparing){11}, she (is making){11}, (she's cooking){11}, (she's preparing){11}, (she's making){11}] breakfast{265}.",
            ]
            
        case .ScientistHome_item_beet_11:
            sentences = [
                "Когда ты обычно просыпаешься?",
            ]
            
            producers = [
                " [(when do){268}, (what time do){268}] you usually<{9} [(wake up){2}, (get up){2}]?",
            ]
            
        case .ScientistHome_item_cabbage_1:
            sentences = [
                "У него есть два брата.",
            ]
            
            producers = [
                " [he has{1}, he (has got){1}, (he's got){1}] [two, 2] brothers{262}.",
            ]
            
        case .ScientistHome_item_cabbage_2:
            sentences = [
                "Кошки никогда не улыбаются."
            ]
            
            producers = [
                "cats never<{7} smile{3}."
            ]
            
        case .ScientistHome_item_cabbage_3:
            sentences = [
                "Она не водит машину.",
            ]
            
            producers = [
                "she [(does not drive){1}, (doesn't drive){1}, (never drives){1}, (can not){156} drive, (can't){156} drive, cannot{156} drive] a{250} car.",
            ]
            
        case .ScientistHome_item_cabbage_4:
            sentences = [
                "Я подготовлю эту презентацию завтра.",
            ]
            
            producers = [
                ">>[tomorrow]{8} [I will prepare{42}, I'll prepare{42}, I will finish{42}, I'll finish{42}] [this, the{253}, that] presentation >><.",
            ]
            
        case .ScientistHome_item_cabbage_5:
            sentences = [
                "Он планирует приготовить пасту вечером.",
            ]
            
            producers = [
                 ">>[in the evening]{8} [he (is going to){56}, he's (going to){56}, he (is planning){14} to, (he's planning){14} to] [make{57}, cook{57}, prepare{57}] pasta{263} >><.",
            ]
        case .SecondHand_item_purse:
            sentences = [
                "Я уверен, они не приедут.",
                "Ты поубираешь у себя в комнате?",
                "Это очень старый дом.",
            ]
            
            producers = [
                " [I'm{197} sure, I'm{197} confident, I'm{197} convinced, I am{197} sure, I am{197} confident, I am{197} convinced, I believe{16}] [they (will not){43}, they won't{43}, (they'll not){43}] come{43}.",
                " [will{266} you clean{42} (your room){264}, will{266} you clean{42} at your room, (are you going to){56} clean at your room, (are you going to){56} clean (your room){264}, (are you planning to){14} clean at your room, (are you planning to){14} clean (your room){264}]?",
                " [this, that] is{198} a{250} [very{249}, really{248}] old [house, building].",
            ]
        case .SecondHand_item_hat:
            sentences = [
                "Где она? Она готовит ужин.",
                "Она не планирует приглашать его на эту вечеринку.",
                "Если она будет усердно учиться, она сдаст экзамены.",
            ]
            
            producers = [
                " [where's{268}, where{268} is{197}] she? [she (is making){11}, (she's making){11}, she (is cooking){11}, she (is preparing){11}, (she's cooking){11}, (she's preparing){11}] dinner{265}.",
                " [she is not, she's not, she isn't] [(going to invite){56}, planning to invite] him to{200} [this, that] party.",
                "if she [studies{111}, works{111}] [hard, a lot], [she (will pass){111}, (she'll pass){111}] [her exams{264}, her examination{264}]",
            ]
        case .SecondHand_item_shoe:
            sentences = [
                "Эта блузка стоит всего 15 долларов, я куплю ее.",
                "Я не планирую приходить туда завтра.",
                "Она живет в квартире?",
            ]
            
            producers = [
                " [this, that] [blouse costs{16}, blouse is{197}, blouse's{197}] [/just, /only] [15 dollars, fifteen dollars, 15$], [I (will buy){45}, (I'll buy){45}] it.",
                ">>[tomorrow]{8} [I am not, I'm not] [(going to go){58}, (going to come){58}, planning to go, planning to come] there >><.",
                "does{266} she live{1} in{220} [a{250} flat, an{250} apartment]?",
                
            ]
        case .SecondHand_item_scarf:
            sentences = [
                "Что ты сейчас делаешь?",
                "Ты планируешь рассказать ему об этом?",
                "Поторопись! Твой поезд уезжает через 20 минут.",
            ]
            
            producers = [
                "what{266} are you doing{11} now{8}?",
                "are{266} you [(going to tell){58}, planning to tell] him about{238} [it, this, that]?",
                " [hurry{272}, (hurry up){272}]! [the{253}, your{264}] train [leaves{4}, departs{4}] in{211} [twenty, 20, twony] [min, minutes].",
            ]
        case .SecondHand_item_dress:
            sentences = [
                "Что она любит делать по выходным?",
                "Она поможет тебе после работы.",
                "Мой отец планирует купить новую машину в этом году.",
            ]
            
            producers = [
                "what{268} does she like{1} doing{151} [(on weekends){218}, (at the weekend){214}]?",
                ">>[after work]{8} [she (will help){44}, (she'll help){44}] you >><.",
                 ">>[this year]{8} my [father is, dad is, father's, dad's] [(going to buy){58}, (going to purchase){58}, planning to buy] a{250} new car >><.",
            ]
        case .SecondHand_item_robe:
            sentences = [
                "Скорпионы очень опасны.",
                "Она бы хотела жить за границей.",
                "Зима наступает после осени.",
            ]
            
            producers = [
                "scorpions{262} are{197} [very{249}, really{248}] dangerous.",
                " [she (would like to){59}, (she'd like){59}] live abroad{204}.",
                "/the winter [comes{3}, starts{3}] after /the [autumn, fall].",
            ]
        case .SecondHand_item_fittingRoom:
            sentences = [
                "Я не пойду в бассейн сегодня.",
                "На рождество мы планируем навестить наших родственников.",
                "Если он не позвонит, я не расскажу ему об этом.",
            ]
            
            producers = [
                ">>[today]{8} [I (will not go){42}, I (won't go){42}, (I'll not go){42}] to{200} the{257} [swimming pool, pool] >><.",
                ">>[at Christmas, on Christmas Day]{8} [we (are planning){14} to{201}, (we're planning){14} to{201}, (we are going to){56}, (we're going to){56}] [visit (our relatives){264}, visit (our family){264}, give (our relatives){264} a visit, give (our family){264} a visit] >><.",
                " [if he (doesn't call){111}, if (he does not call){111}, unless he calls{111}] me, [I (will not tell){111}, (I'll not tell){111}, I (won't tell){111}] him about{238} [it, this, that].",
            ]
            
        case .Factory_Street_item_closedDoor:
            sentences = [
                "Она напишет письмо тебе послезавтра.",
                "Посмотри на эту машину! Она сейчас врежется в это дерево.",
                "На пасху мы обычно едим яйца.",
            ]
            
            producers = [
                ">>[the day after tomorrow]{8} [she will{42}, she'll{42}] [write{42} you a{250} letter, write{42} a{250} letter to you] >><.",
                "look{272} at{242} [this, that] car! [it (is going to){57}, (it's going to){57}] [break{57}, bump{57}, crash{57}] [into{200}, to{200}] [this, that] tree!",
                ">>[at Easter]{8} we usually<{9} eat{2} eggs >><.",
            ]
            
        case .Factory_Street_item_turnOnFan:
            sentences = [
                "Я приму решение завтра.",
                "Она собирается идти спать.",
                "Почему она всегда грустная?",
            ]
            
            producers = [
                ">>[tomorrow]{8} [I'll{44}, I will{44}] [decide{44}, make{44} a{250} decision, take{44} a{250} decision, make{44} my decision{264}, make this decision, make that decision, take this decison, take that decision, make this decision, make that decision] >><.",
                " [she (is going to go){56}, she's (going to go){56}, she (is planning){12} to go, (she's planning){12} to go] to{200} bed.",
                " [why{268} is{197}, why's{268}] she always{10} [sad, upset, gloomy]?",
            ]
            
        case .Factory_Stock_item_lift:
            sentences = [
                "Моя сестра хочет переехать в новую квартиру в этом месяце.",
                "Он планирует продать свой мотоцикл.",
                "Каждый понедельник моя подруга ходит в зал.",
                "Давай встретимся в пятницу вечером.",
            ]
            
            producers = [
                ">>[this month]{8} (my sister){264} wants{16} to{201} move to{200} a{250} new [flat, apartment] >><.",
                " [he is, he's] [planning{12} to{201}, (going to){56}] sell [(his motorbike){264}, (his motorcycle){264}, (his bike){264}].",
                ">>[every Monday, on Monday, on Mondays]{8} [(my friend){264}, (my girlfriend){264}] goes{2} to{200} the{257} gym >><.",
                " [(let us){272}, let's{272}] [meet, see each other, have a{250} meeting] [on{216} Friday evening, on{215} Friday in{205} the evening, in{205} the evening on{215} Friday].",
            ]
            
        case .Factory_Corridor_1_item_door:
            sentences = [
                "Я помогу тебе, если ты попросишь.",
                "Я перезвоню тебе через 5 минут.",
                "Сколько это стоит?",
            ]
            
            producers = [
                 " [I (will help){111} you, I (will help){111} you out, I (will give){111} you a hand, (I'll help){111} you, (I'll help){111} you out, (I'll will give){111} you a hand] if you ask{111} me.",
                 ">>[in five minutes, in 5 minutes, in 5 min] [I will{44}, I'll{44}] [call{44} you, call{44} you back, return{44} your call] >><.",
                  "(how much){268} [does it cost{1}, does this cost{1}, does that cost{1}, is{197} this, is{197} that, is{197} it]?",
                 
            ]
            
        case .Factory_Corridor_3_item_door:
            sentences = [
                "Когда ты пойдёшь домой?",
                "Он постоянно толкает меня!",
                "Возможно они переедут в новую квартиру в этом году.",
                "Последний поезд в Берлин отходит в полночь.",
            ]
            
            producers = [
                "when{268} [(will you go){42}, (are you going){56} to{201} go, are you planning to{201} go] home{204}?",
                " [He is, he's] [constantly<{9}, always<{9}] pushing{15} me!",
                ">>[this year]{8} [they will{42}, they'll{42}] [probably<{9}, /probably] [(move to){42}, (move in){42}, (move into){42}] [a{250}, their] new [flat, apartment] >><.",
                "the{253} last train to{200} Berlin [is{197}, leaves{4}, departs{4}] at{212} midnight.",
            ]
            
        case .Factory_Corridor_6_item_door:
            sentences = [
                "Я планирую открыть свой бизнес.",
                "Ее родители купят ей новую игрушку сегодня.",
                "Я планирую дописать свою книгу в след году.",
                "Она не будет с тобой разговаривать.",
            ]
            
            producers = [
                " [I (am going to){56}, (I'm going to){56}, I am planning to, I'm planning to] [open{56}, start{56}] [my, my own] business.",
                ">>[today]{8} her parents (will buy){44} her a{250} new toy >><.",
                ">>[next year]{8} [(I am going to write){56}, (I am going to finish){56}, (I'm going to write){56}, (I'm going to finish){56}, I am planning to write, I'm planning to write] (my book){264} >><.",
                " [she (will not){43}, (she'll not){43}, she won't{43}] [(talk to){43}, (speak to){43}, (speak with){43}] you.",
                
            ]
            
        case .Factory_Data_item_monitor:
            sentences = [
                "Ты не любишь футбол, не так ли?",
                "Я сейчас иду в магазин, чтобы купить вино.",
                "Они возможно спросят тебя об этом.",
                "Поторопись! Спектакль начнётся через 5 минут.",
            ]
            
            producers = [
                "you [do not like{16}, don't like{16}, dislike{16}] [football, soccer], (do you){271}?",
                "/now [I (am going){11} to{200}, (I'm going){11} to{200}, I (am going){11} to{200} go, (I'm going){11} to{200} go]  the{257} [shop, store] to{202} buy /some wine{263} /now.",
                "they [will{42} /probably, may{188}, might{188}] ask you about{238} [this, it, that].",
                " [hurry{272}, (hurry up){272}]! The{253} [play, show, performance] [starts{4}, begins{4}] in{211} [5 minutes, five minutes, 5 min, five min].",
            ]
            
        case .Factory_AI_item_computer_right:
            sentences = [
                "Мы улетаем в Нью Йорк завтра, чтобы навестить наших друзей.",
                "Он расскажет тебе все позже.",
                "Если ты голоден, я приготовлю что-то покушать.",
                "Мы обсуждаем этот вопрос в настоящий момент.",
                "Осторожно! Ты сейчас разобьёшь эту вазу!",
                "Они планируют съездить в Италию в мае.",
            ]
            
            producers = [
                ">>[tomorrow]{8} [we (are flying){14}, (we're flying){14}] to{200} New York{261} to{202} [see, visit] (our friends){264} >><.",
                " [he (will tell){44}, (he'll tell){44}] you everything later.",
                "if [you are{197}, you're{197}] hungry{111}, [I (will cook){111}, I (will make){111}, I (will prepare){111}, (I'll cook){111}, (I'll make){111}, (I'll prepare){111}] something [/to eat, ].",
                ">>[now, at the moment, right now, at present]{8} [we (are discussing){11}, (we're discussing){11}, we (are talking){11} about{238}, (we're talking){11} about{238}] [this, that] question >><.",
                " [careful{272}, (be careful){272}]! you (are going to){57} [break{57}, crash{57}] [this, that] vase!",
                ">>[in May]{8} [they (are planning){14} to{201}, they're planning{14} to{201}, (they are going to){56}, (they're going to){56}] [go, travel] to{200} Italy{261} >><.",
            ]
        case .Factory_AI_item_computer_center:
            sentences = [
                "В котором часу ты просыпаешься утром?",
                "Я больше никогда не буду врать!",
                "Посмотри на небо! Сейчас точно пойдёт дождь.",
                "Ты любишь чай или кофе?",
                "В следующем году я пробегу марафон.",
                "Фермеры обычно просыпаются на рассвете.",
            ]
            
            producers = [
                " [(what time){268}, when{268}] do you [(wake up){2}, (get up){2}] in{205} the morning?",
                " [I will{44}, I'll{44}] never<{9} [lie{44}, (tell lies){44}] /again.",
                "look{272} at{242} the{260} sky! [it (is going to rain){57}, (it's going to rain){57}] /now!",
                "do you like{16} tea{263} or{269} coffee{263}?",
                ">>[next year]{8} [I (will run){42}, (I'll run){42}] [a{250}, this, that] marathon >><.",
                "Farmers{262} usually<{9} [(wake up){2}, (get up){2}] at{214} [sunrise, dawn]."
            ]
        case .Factory_AI_item_computer_left:
            sentences = [
                "Я уверен, он споёт эту песню сегодня.",
                "Мы планируем сходить в кино в воскресенье вечером.",
                "Я пойду на эту вечеринку, если он меня пригласит.",
                "Они всегда ходят в парк на выходных.",
                "Она звонит маме каждую среду.",
                "Я никогда тебя не прощу.",
            ]
            
            producers = [
                ">>[today]{8} [I'm{197}, I am{197}] [sure, confident, convinced], [he (will sing){43}, (he'll sing){43}] [this, the{253}, that] song >><.",
                ">>[on Sunday in the evening, on Sunday evening, in the evening on Sunday]{8} [(we are going to){56}, (we're going to){56}, we (are planning){14} to{201}, (we're planning){14} to{201}] go to{200} the{257} [cinema, movies, movie theatre, movie theater] >><.",
                " [I (will go){111}, I (will come){111}, (I'll go){111}, (I'll come){111}] to{200} [the{253}, this, that] party, if he invites{111} me.",
                ">>[on weekends, at the weekend]{8} they always<{9} go{2} to{200} the{257} park >><.",
                ">>[every Wednesday]{8} she [calls{2}, phones{2}] [(her mother){264}, (her mom){264}, (her mum){264}] >><.",
                " [I'll{44}, I will{44}] never<{9} forgive{44} you.",
            ]
        }
        
        
        
        
        precondition(sentences.count == producers.count)
        data = sentences.count.reduce([], { (result, index) in
            let pair = TranslateProducerPair(
                sentenceToTranslate: sentences[index],
                producer: producers[index]
            )
            
            return result.appending(pair)
        })
        
        self.sentence = sentence
    }
}

extension CheckSentenceData {
    struct TranslateProducerPair: Codable {
        let sentenceToTranslate: String
        let producer: String
    }
}

