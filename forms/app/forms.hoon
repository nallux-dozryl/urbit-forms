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
++  on-poke   :: on-poke:def
  |=  [=mark =vase]
  ^-  (quip card _this)
  |^
  ?+  mark  (on-poke:def mark vase)
    %forms-action
    =^  cards  state
      (handle-action !<(action vase))
      [cards this]
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
      =+  survey=(create-survey:fl act our.bowl now.bowl)
      =/  new-slugs  ^+  slugs
        (~(put by slugs) slug.act id)
      =/  new-surveys  ^+  surveys
        (put:s-orm:fl surveys id survey)
      `state(surveys new-surveys, slugs new-slugs)
      ::
      %delete
      ~|  'survey does not exist'
      =+  survey=(need (get:s-orm:fl surveys survey-id.act))
      =+  new-surveys=+:(del:s-orm:fl surveys survey-id.act)
      =+  new-slugs=(~(del by slugs) slug.survey)
      :_  state(surveys new-surveys, slugs new-slugs)
      ?.  =(our.bowl author.survey)
      :~  :*
        %pass   /updates/(scot %ud survey-id.act)
        %agent  [author.survey %forms]  %leave  ~
      ==  ==
      :~  :*
        %give  %fact  ~[/survey/(scot %ud survey-id.act)]
        %forms-update  !>  leave+survey-id.act
      ==  ==
      ::
      %edit
      ~|  'information incorrect'
      =+  survey=(need (get:s-orm:fl surveys survey-id.act))
      =+  data=`edit`+7.act
      :-  ?.  =(our.bowl author.survey)  ~
      :~  :*
        %give  %fact   ~[/survey/(scot %ud survey-id.act)]
        %forms-update  !>  `update`edit+data
      ==  ==
      %=  state  surveys  ^+  surveys
      %-  put:s-orm:fl  :+  surveys  survey-id.act
        ?-  -.data
          %title
          =.  title.survey
            title.data
          survey
          ::
          %description
          =.  description.survey
            description.data
          survey
          ::
          %visibility
          =.  visibility.survey
            visibility.data
          survey
          ::
          %slug
          =.  slug.survey
            slug.data
          survey
        ==
      ==
    ==
  ++  handle-request
    |=  req=request
    ^-  (quip card _state)
    ?-  -.req
      %ask
      :_  state(pending (~(put in pending) [author.req slug.req]))
      :~  :*
        %pass   /slug
        %agent  [author.req %forms]
        %poke   %forms-request  !>  slug+slug.req
      ==  ==
      ::
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
++  on-watch  ::on-watch:def
  |=  =path
  ^-  (quip card _this)
  ?+  path  (on-watch:def path)
    [%survey @ ~]
    =/  id=survey-id   (slav %ud i.t.path)
    =+  survey=(need (get:s-orm:fl surveys id))
    ~|  'invalid permissions'
    ?>  =(%public visibility.survey)
    :_  this
    :~  :*
      %give  %fact   ~
      %forms-update  !>  `update`survey+survey
    ==  ==
  ==
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  ::on-agent:def
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
      ?~  p.sign  (on-agent:def wire sign)
      %-  %-  slog  ^-  tang  (need p.sign)  `this
      ::
      %kick
      =+  id=(slav %ud i.t.wire)
      :_  this
      :~  :*
        %pass   [%updates i.t.wire ~]
        %agent  [src.bowl %forms]
        %watch  [%survey i.t.wire ~]
      ==  ==
      ::
      %fact
      ?+  p.cage.sign  (on-agent:def wire sign)
        %forms-update
        =/  id=survey-id  (slav %ud i.t.wire)
        =+  upd=!<(update q.cage.sign)
        ?-  -.upd  ::(on-agent:def wire sign)
          %survey
          =/  new-surveys  ^+  surveys
            (put:s-orm:fl surveys id survey.upd)
          `this(surveys new-surveys)
          ::
          %leave
          :_  this
          :~  :*
            %pass   wire
            %agent  [src.bowl %forms]
            %leave  ~
          ==  ==
          ::
          %edit
          ~|  'did not work'
          =+  survey=(need (get:s-orm:fl surveys id))
          ?>  =(src.bowl author.survey)
          :_  this
          :~  :*
            %pass   /edit
            %agent  [our.bowl %forms]
            %poke   %forms-action  !>  `action`edit+[id +.upd]
          ==  ==
        ==
      ==
    ==
  ==
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
