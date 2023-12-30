import UIKit

/*Давайте представим, что у нас есть приложение для мониторинга погоды. Мы хотим добавить функциональность, которая позволит пользователям подписываться на уведомления о изменении погоды в определенном городе.

Задача для паттерна "наблюдатель" может быть следующей:

1. Создать класс WeatherData, который будет содержать информацию о текущей погоде в определенном городе, такую как температура, влажность, скорость ветра и т.д.

2. Создать интерфейс WeatherObserver, который будет являться наблюдателем за изменениями погоды. Он будет иметь метод update(weatherData: WeatherData), который будет вызываться при каждом изменении погоды.

3. Создать класс WeatherStation, который будет отслеживать данные о погоде и уведомлять зарегистрированных наблюдателей о каждом изменении.

4. Пользователи приложения смогут подписаться на уведомления о погоде в определенном городе, чтобы получать информацию о текущей погоде и обновлениях в режиме реального времени.

Таким образом, при каждом изменении данных о погоде, WeatherStation будет уведомлять всех зарегистрированных наблюдателей (экземпляры WeatherObserver) о новых данных, и они смогут обновить свои данные и отобразить информацию о погоде в реальном времени.*/

/*Конечно, вот последовательность шагов для реализации этой задачи на Swift:

1. Создайте класс WeatherData для хранения информации о погоде. В этом классе будут свойства, такие как температура, влажность, скорость ветра и т.д.

class WeatherData {
    var temperature: Double = 0.0
    var humidity: Double = 0.0
    var windSpeed: Double = 0.0
    // Другие свойства погоды
}


2. Создайте протокол WeatherObserver с методом update, который будет вызываться при обновлении данных о погоде.

protocol WeatherObserver {
    func update(weatherData: WeatherData)
}


3. Создайте класс WeatherStation, который будет отслеживать данные о погоде и уведомлять зарегистрированных наблюдателей о каждом изменении. В этом классе будут методы для регистрации и удаления наблюдателей, а также методы для обновления данных о погоде.

class WeatherStation {
    private var observers: [WeatherObserver] = []
    private var currentWeatherData = WeatherData()

    func registerObserver(observer: WeatherObserver) {
        observers.append(observer)
    }

    func removeObserver(observer: WeatherObserver) {
        if let index = observers.firstIndex(where: { $0 === observer }) {
            observers.remove(at: index)
        }
    }

    func notifyObservers() {
        for observer in observers {
            observer.update(weatherData: currentWeatherData)
        }
    }

    func setWeatherData(temperature: Double, humidity: Double, windSpeed: Double) {
        currentWeatherData.temperature = temperature
        currentWeatherData.humidity = humidity
        currentWeatherData.windSpeed = windSpeed
        // Обновление других данных о погоде

        // Уведомление наблюдателей о новых данных
        notifyObservers()
    }
}


4. Теперь можно создать классы или структуры, которые реализуют протокол WeatherObserver и будут получать уведомления о изменениях погоды.

class UserInterface: WeatherObserver {
    func update(weatherData: WeatherData) {
        // Обновление пользовательского интерфейса с новыми данными о погоде
    }
}

class MobileApp: WeatherObserver {
    func update(weatherData: WeatherData) {
        // Отправка уведомлений в мобильное приложение о новых данных о погоде
    }
}


5. Наконец, создайте экземпляр WeatherStation, зарегистрируйте в нем экземпляры классов или структур, реализующих протокол WeatherObserver, и обновите данные о погоде.

let weatherStation = WeatherStation()
let userInterface = UserInterface()
let mobileApp = MobileApp()

weatherStation.registerObserver(observer: userInterface)
weatherStation.registerObserver(observer: mobileApp)

// Обновление данных о погоде вызовет уведомление всех зарегистрированных наблюдателей
weatherStation.setWeatherData(temperature: 25.0, humidity: 60.0, windSpeed: 10.0)


Таким образом, при вызове setWeatherData в WeatherStation, все зарегистрированные наблюдатели получат уведомление о новых данных о погоде и смогут обновить свои данные или интерфейс в соответствии с этими изменениями. */
    











