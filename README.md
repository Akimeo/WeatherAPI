# Weather API

Из-за того, что количество запросов по бесплатному api ключу AccuWeather
действительно сильно ограничено, было принято решение пойти на несколько
компромиссов. Некоторые из них, если я правильно понял, предполагались
условием тестового задания.

Некоторые принципы работы приложения:

* app/services/pull_weather_service.rb обрабатывает данные о погоде, которые
присылает lib/clients/accu_weather_client.rb, и сохраняет их в базу

* Все данные приходят для Москвы, время тоже московское

* Все время сохраняется с точностью до часа с округлением вниз

* Таким образом, когда приложение запускается впервые, в базу сохраняются
данные за последние 24 часа

* Далее каждый час подгружается информация о текущем времени

* Наш api обращается только к этим данным

* Соответственно, все ответы тоже предоставляются с точностью до часа с
округлением вниз

* Если будете разворачивать приложение, не забудьте создать файл .env
по образу и подобию .env.example
