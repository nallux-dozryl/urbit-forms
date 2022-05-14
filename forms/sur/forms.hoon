|%
:: Top Level
+$  shelf   (map sv-author surveys)
+$  slugs    (map =slug sv-id)
+$  pending  (set [sv-author slug])

+$  sv-author  ship    +$  slug      @ta

::  unix time          ::  placeholder type
+$  sv-id      @ud     +$  question  @t 

+$  visibility  ?(%public %private %team)

+$  questions  (map question-id=@ud question)  

+$  survey        (map @t sv-data)
+$  surveys       ((mop sv-id survey) gth)
+$  sv-data
  $%  @t
      slug
      questions
      visibility
  ==

::  Actions
+$  action
  $%  create
      :: edit
      :: delete
      :: submit
      ask
      request
      receive
      unsub
  ==
+$  create   [%create title=@t description=@t =visibility =slug]
+$  ask      [%ask =sv-author =slug]
+$  request  [%request =slug]
+$  receive  [%receive =slug =sv-id]
+$  unsub    [%unsub =sv-author =sv-id]

::  Updates
+$  update
  $%  [%survey =survey]
  ==
--















