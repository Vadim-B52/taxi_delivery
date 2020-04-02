/*

https://www.figma.com/file/OdsOGd8vWQhMxjaoTjtIvM/Беру-доставка?node-id=0%3A1


## Полезные материалы

* [flutter.dev](https://flutter.dev) и [dart.dev](https://dart.dev)
-- официальные страницы.

* [pub.dev](https://pub.dev)
-- каталог библиотек.

* [Flutter in Focus](https://www.youtube.com/playlist?list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2)
-- короткие (до 10 минут) видео обзоры различных элементов платформы. Как непосредственно по Flutter (виджеты, анимации, etc), так и по Dart (серия по Async Coding).

* Записи сессий конференции [Flutter Interact '19](https://www.youtube.com/playlist?list=PLjxrf2q8roU0o0wKRJTjyN0pSUA6TI8lg). Пока посмотрел только keynote'ы и некоторые #AskFlutter сессии.

* Серия статей [Unboxing Packages](https://news.dartlang.org/search/label/Unboxing%20Packages), в частности: [async part 1][unboxing async part 1], [async part 2][unboxing async part 2], [async part 3][unboxing async part 3], [collection][unboxing collection]

[unboxing async part 1]: https://news.dartlang.org/2016/03/unboxing-packages-async-part-1.html
[unboxing async part 2]: https://news.dartlang.org/2016/03/unboxing-packages-async-part-2.html
[unboxing async part 3]: https://news.dartlang.org/2016/04/unboxing-packages-async-part-3.html
[unboxing collection]: https://news.dartlang.org/2016/01/unboxing-packages-collection.html


minitask:
  id: <...>
  type: pickup
  address: Невский проспект, 42, оф. 7
  description: Lorem ipsum
  packages:
    - package_id: x
      status: pending
    - package_id: y
      status: picked
    - package_id: z
      status:
  actions:
    - type: начать_забор
    - type: decline
      available_reasons:
        - x
        - y
        - z

action:
  task_id: <...>
  type: decline_pickup
  reason: x
  comment: <...>

action:
  task_id: <...>
  type: confirm_pickup
  packages:
    - package_id: <...>
      media_asset: <... base64 encoded data ...>

minitask:
  id: <...>
  type: delivery
  address: Большой проспект, 11, кв. 4
  packages:
    - package_id: <...>
    - package_id: <...>
  actions:
    - type: связаться_с_получателем
      phone: +7 123 456 78 90
    - type: pospone_delivery
    - type: confirm_delivery

action:
  task_id: <...>
  type: postone_delivery
  by:
    value: 2
    unit: hour
  reason: client
  comment: <...>

action:
  task_id: <...>
  type: confirm_delivery
  confirmation_code: v3rySecr3t

minitask:
 - описание
 - доступные действия
 - сабмит результатов для каждого действия

общие действия
 - завершить смену
 - связаться с тех-поддержкой

action:
  type: common_end_day

 */