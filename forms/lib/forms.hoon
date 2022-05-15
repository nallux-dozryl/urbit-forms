/-  *forms
|%
++  s-orm   ((on survey-id survey) gth)
++  make-survey-id
  |=  [now=@da =author]
  ^-  survey-id
  =/  present=@ub  (mul 4.294.967.296 (unm:chrono:userlib now))
  =/  ship-hash=@ub     (shaw author 32 author)
  (add present ship-hash)

++  create-survey
  |=  [act=create =author =spawn-time]
  ^-  survey
  :*  author
      slug.act
      title.act
      description.act
      visibility.act
      spawn-time
      *questions
  ==

  
++  remove-json
  |=  data=json
  data
::(crip (en-json:html data))
::  ((op so):dejs:format data)
--
