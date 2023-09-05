//
//  Post.swift
//  Navigation
//
//  Created by Александр Садыков on 08.08.2023.
//

import Foundation


public struct BlankPost {
    public var title: String
    public init(title: String) {
        self.title = title
    }
}

public struct Post {
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
}

public let feedPost: [Post] = [
    Post(author: "Животные в добрые руки Оренбург",
         description: "Отдам котят помесь бенгальской породы. Два мальчика, возраст 1,5 месяцев. Кушают всё, ходят в лоток. телефон для связи +79058465265",
         image: "cats",
         likes: 12,
         views: 77),
    Post(author: "Yandex Fashion Day",
         description: "Приглашаем вас на бесплатную конференцию. Мы позвали представителей fashion-компаний и специалистов Яндекса. Они поделятся свежей статистикой, реальными кейсами и актуальными рекомендациями по продвижению модных брендов.",
         image: "yandex",
         likes: 676,
         views: 1207),
    Post(author: "Ольга Колесникова",
         description: "Наконец-то отпуск) Уехали от городской суеты.. ",
         image: "vacation",
         likes: 23,
         views: 199),
    Post(author: "Халявщики - акции, скидки, халява, промокоды",
         description: "Спасибо нашей читательнице за фото❤ Проверяйте в магазинах или в приложении \"Магнит Доставка\". Такая цена не везде.",
         image: "sale",
         likes: 3,
         views: 776)
]

