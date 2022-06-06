/-  *forms
/+  default-agent, dbug, fl=forms
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
    =surveys
    =slugs
    =pending
    =subscribers
    =access
    =draft
    =submitted
    =received
  ==
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
::
++  on-init
  ^-  (quip card _this)
  `this
::
++  on-save
  ^-  vase
  !>(state)
::
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-state)
  ?-  -.old
    %0  `this(state old)
  ==
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  |^
  ?+  mark  (on-poke:def mark vase)
      %forms-action
    =^  cards  state
      (handle-action !<(action vase))
    [cards this]
    ::
      %forms-request
    =^  cards  state
      (handle-request !<(request vase))
    [cards this]
  ==
  ++  handle-action
    |=  act=action
    ^-  (quip card _state)
    ?>  =(src our):bowl
    ?-  -.act
        %create
      ~|  'slug already exists'
      ?>  =(~ (~(get by slugs) slug.act))
      =+  id=(make-survey-id:fl now.bowl our.bowl)
      =/  this-survey=survey
        (create-survey:fl act our.bowl now.bowl)
      =/  new-slugs
        ^+  slugs
        (~(put by slugs) slug.act id)
      =/  new-surveys  
        ^+  surveys
        (put:s-orm:fl surveys id this-survey)
      :-
        :~  :*
          %give  %fact   ~[/json]
          %forms-json  !>  surveys+surveys
        ==  ==
      %=  state
        surveys      new-surveys
        slugs        new-slugs
        subscribers  (~(put in subscribers) id *ships)
      ==
      ::
        %ask
      :_  state(pending (~(put in pending) [author.act slug.act]))
      :~  :*
        %pass   /slug
        %agent  [author.act %forms]
        %poke   %forms-request  !>  slug+slug.act
      ==  ==
    ==
      ::
  ++  handle-request
    |=  req=request
    ^-  (quip card _state)
    ?-  -.req
        %slug
      =+  id=(~(get by slugs) slug.req)
      :_  state
      :~  :*
        %pass   /slug
        %agent  [src.bowl %forms]
        %poke   %forms-request  !>
        ?~  id  fail+slug.req  id+[slug.req (need id)]
        ==  ==
      ::
      %fail
      %-  (slog leaf+"forms doesn't exist!" ~)
      `state(pending (~(del in pending) [src.bowl slug.req]))
      ::
      %id
      %-  (slog leaf+"subscribing to survey" ~)
      :_  state(pending (~(del in pending) [src.bowl slug.req]))
      :~  :*
        %pass   /updates/(scot %ud survey-id.req)
        %agent  [src.bowl %forms]
        %watch  /survey/(scot %ud survey-id.req)
      ==  ==
    ==
  --  
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+  path  (on-watch:def path)
      [%survey @ ~]
    =/  id=survey-id   (slav %ud i.t.path)
    =+  survey=(need (get:s-orm:fl surveys id))
    ~|  'invalid permissions'
    ?>  =(%public visibility.survey)
    :_  this(subscribers (add-subs:fl subscribers id src.bowl))
    :~  :*
      %give  %fact   ~
      %forms-update  !>  `update`survey+survey
    ==  ==
      [%json ~]
    :_  this
    :~  :*
      %give  %fact   ~
      %forms-json  !>  surveys+surveys
      ==  ==
  ==
++  on-leave  on-leave:def
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  (on-peek:def path)
      [%x %surveys *]
      ~&  >>  'req surveys'
      :^  ~  ~  %forms-json
      !>  ^-  frontend
      surveys+surveys
  ==
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+  wire  (on-agent:def wire sign)
    [%slug ~]
    ?.  ?=(%poke-ack -.sign)  (on-agent:def wire sign)
    ?~  p.sign
      `this
      %-  %-  slog  ^-  tang  (need p.sign)  `this
    ::
    [%leave ~]
    ?.  ?=(%poke-ack -.sign)  (on-agent:def wire sign)
    ?~  p.sign
      `this
      %-  %-  slog  ^-  tang  (need p.sign)  `this
    ::
    [%edit ~]
    ?.  ?=(%poke-ack -.sign)  (on-agent:def wire sign)
    ?~  p.sign
      `this
      %-  %-  slog  ^-  tang  (need p.sign)  `this
    ::
    [%updates @ ~]
    ?+  -.sign  (on-agent:def wire sign)
      %watch-ack
      ~&  >>>  'watch aack'
      ?~  p.sign  (on-agent:def wire sign)
      %-  %-  slog  ^-  tang  (need p.sign)  `this
      ::
      %kick
      ~&  >>>  'kicked'
      =+  id=(slav %ud i.t.wire)
      =+  survey=(need (get:s-orm:fl surveys id))
      =.  status.survey  %archived
      =+  new-surveys=(put:s-orm:fl surveys id survey)
      `this(surveys new-surveys)
      ::
      %fact
      ~&  >>>  'fax'
      ?+  p.cage.sign  (on-agent:def wire sign)
        %forms-update
        =/  id=survey-id  (slav %ud i.t.wire)
        =+  upd=!<(update q.cage.sign)
        ?-  -.upd
          %survey
          =/  new-surveys  ^+  surveys
            (put:s-orm:fl surveys id survey.upd)
          `this(surveys new-surveys)
          ::
        ==
      ==
    ==
  ==
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
