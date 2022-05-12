/-  *forms
|%
++  create-survey
  |=  [=action now=@da]
  ^-  [sv-id json]
  :-  (unm:chrono:userlib now)
  %-  pairs:enjs:format
  :~  ['title' s+title.action]
      ['description' s+description.action]
      ['visibility' s+visibility.action]
      ['slug' s+slug.action]
      ['questions' o+*(map @t json)]
  ==
--
