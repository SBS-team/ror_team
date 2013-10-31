# RorTeam

## Описание сайта

 RorTeam - это сайт, целью которого является представить широкой общественности команду RubyOnRails разработчиков из Запорожья. На главной странице собрана краткая информация со всех разделов сайта: неполный перечень применяемых технологий, несколько ссылок на уже реализованные проекты и на публикации наших разработчиков. Также здесь можно ознакомиться с нашими вакансиями.

 С любой страницы сайта пользователь в случае необходимости может воспользоватся одним из предоставленных механизмов обратной связи: отправить email запрос, задать вопрос одному из наших менеджеров посредством Live Chat или связаться с нами через Twitter и Facebook.

 На странице Company отображен полный перечень технологий, которые наши разработчики применяют при написании проектов. Для удобства и наглядности они разбиты на отдельные группы. Также на данной странице приводится исчерпывающий список услуг и сервисов, которые возможно у нас заказать. Все это позволяет потенциальному заказчику сделать наиболее оптимальный для него выбор.

 На странице Work представлены обзоры наиболее интересных и показательных проектов, которые приходилось выполнять нашей команде разработчиков. Эта информация позволяет потенциальному заказчику удостоверится в наших навыках, а также рассмотреть возможные варианты решения его задачи, оценить сроки и ресурсы.

 На странице Team размещена краткая информация о каждом члене нашей команды: навыки, опыт

 На вкладке Careers соискатели могут ознакомиться с вакансиями открытыми нашей компанией, а также заполнить свои контактные данные и краткое резюме в специальную форму и отправить нам на рассмотрение запрос. Так как написание резюме может быть утомительным, то предусмотрена возможность прикрепления соответствующего файла к запросу.

 На странице Contact представлены формы для обратной связи. Здесь можно отправить электронное письмо с запросом или связаться с нашим менеджером для онлайн консультации.

 На вкладке Blog выводится список всех публикаций, написанных нашими разработчиками. Эти посты носят информационный и ознакомительный характер и освещают некоторые вопросы связанные с разработкой и поддержкой RubyOnRails приложений. Эти статьи могут оказаться полезными как соискателям трудоустройства, так и потенциальным заказчикам при формировании задачи и формулировании технического задания. Для более удобного поиска необходимой информации все публикации разделены на категории в зависимости от тематики и имеют соответствующие теги. Постоянные посетители нашего сайта могут подписаться на RSS ленту.

## Requirements

  * ruby 2.0.0p247
  * Rails 4.0.0
  * PostgreSQL > 9.2

## Инструкция по запуску сайта rorteam

- Зайти на репизиторий rorteam https://github.com/SBS-team/ror_team
- Клонировать проект:

        git clone https://github.com/SBS-team/ror_team.git

- Перейти в папку с проектом
- Установить гемы:

        bundle install

- Создать файл настроек подключения к серверу БД 'config/database.yml' на основании файла 'config/database.yml.example'
- Создать БД

        rake db:create

- Выполнить миграции БД

        rake db:migrate

- Наполнить БД данными

        rake db:seed

Сайт предусматривает возможность обратной связи посредством отправки письма по электронной почте или отправки сообщения в LiveChat. Для обеспечения этой функциональности необходимо создать файл настроек в соответсвии со средой в которой вы хотите запустить проект. Например для проверки в среде production -  'config/environments/production.yml' используя как пример файл 'config/environments/development.yml.example'.

Для запуска чата необходимо установить дополнительное ПО:
- Redis Server
- Slanger Server

Для установки Redis Server необходимо последовательно выполнить следующие действия:

        $ wget http://download.redis.io/redis-stable.tar.gz
        $ tar xvzf redis-stable.tar.gz
        $ cd redis-stable
        $ make

Для более комфорной работы с Redis Server также можно выполнить следующие команды:

        $ sudo cp redis-server /usr/local/bin/
        $ sudo cp redis-cli /usr/local/bin/

Для установки Slanger Server необходимо последовательно выполнить:

        $ gem install slanger

Указанное ПО запускается с указанием следующих ключей:

        redis-server --port 4040 &
        slanger --app_key YOUR_KEY --secret YOUR_SECRET -a 127.0.0.1:4567 -w 127.0.0.1:3004

где YOUR_KEY и YOUR_SECRET - это строки-ключи, указанные в файле 'config/environments/production.yml'.

Данное приложение для работы с графическими изображениями использует библиотеку RMagic, которую необходимо дополнительно установить выполнив следующие команды:

        $ sudo apt-get install libmagickwand-dev
        $ sudo apt-get install graphicsmagick-libmagick-dev-compat
        $ sudo apt-get install imagemagick
        $ sudo apt-get install libmagick9-dev

В папке с клонированным проектом

        $ rails s

Откройте ваш браузер и в адресной строке введите localhost:3000


