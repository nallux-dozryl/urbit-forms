/-  *forms
/+  default-agent, dbug, fl=forms
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
    =surveys
    =defunct
    =slugs
    =pending
    =subscribers
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
        ~&  >  id
      :-  ~
      %=  state
        surveys      new-surveys
        slugs        new-slugs
        subscribers  (~(put in subscribers) id *ships)
      ==
      ::
      %clone
      ~|  'cloning failed'
      ?>  =(~ (~(get by slugs) slug.act))
      =+  id=(make-survey-id:fl now.bowl our.bowl)
      =/  new-slugs  ^+  slugs
        (~(put by slugs) slug.act id)
      =/  jango=survey
        ?-  status.act
          %live
          (need (get:s-orm:fl surveys survey-id.act))
          %defunct
          (need (get:s-orm:fl defunct survey-id.act))
        ==
      =+  boba=(clone-survey:fl act jango our.bowl now.bowl)
      =+  new-surveys=^+(surveys (put:s-orm:fl surveys id boba))
      :-  ~
      %=  state
        surveys      new-surveys
        slugs        new-slugs
        subscribers  (~(put in subscribers) id *ships)
      ==
      ::
      %delete
      ?.  =(%live status.act)
        =+  new-defunct=+:(del:s-orm:fl defunct survey-id.act)
        `state(defunct new-defunct)
      ~|  'survey does not exist'
      =+  survey=(need (get:s-orm:fl surveys survey-id.act))
      =+  new-surveys=+:(del:s-orm:fl surveys survey-id.act)
      =+  new-slugs=(~(del by slugs) slug.survey)
      ?.  =(our.bowl author.survey)
        :-
        :~  :*
          %pass
          /updates/(scot %ud survey-id.act)
          %agent
          [author.survey %forms]
          %leave  ~
        ==  ==
        %=  state
          surveys  new-surveys
          slugs    new-slugs
        ==
      =/  subs
        ~(tap in (need (~(get by subscribers) survey-id.act)))
      :_  %=  state
            surveys      new-surveys
            slugs        new-slugs
            subscribers  (~(del by subscribers) survey-id.act)
          ==
      ?:  =(0 (lent subs))
        ~
      %+  turn
        subs
      |=(a=@p [%give %kick ~[/survey/(scot %ud survey-id.act)] `a])
      ::
      %edit
      ~|  'information incorrect'
      =+  this-survey=`survey`(need (get:s-orm:fl surveys survey-id.act))
      ?>  =(our.bowl author.this-survey)
      =+  untouched-slug=slug.this-survey
      =+  data=`edit`+7.act
      =/  new-surveys  ^+  surveys
        %^    put:s-orm:fl
            surveys
          survey-id.act
        ?-  -.data
            %title
          =.  title.this-survey
           title.data
          this-survey
          ::
            %description
          =.  description.this-survey
            description.data
          this-survey
          ::
            %visibility
          =.  visibility.this-survey
            visibility.data
          this-survey
          ::
            %slug
          =.  slug.this-survey
            slug.data
          this-survey
          ::
            %add-q
          =+  count=q-count.this-survey
          ?>  =(count ~(wyt by questions.this-survey))
          =/  ques=question  +.data
          =/  this-questions=questions  questions.this-survey
          =/  new-questions=questions
            (put:q-orm:fl this-questions +(count) ques)
          =.  questions.this-survey
            new-questions
          =.  q-count.this-survey
            +(count)
          this-survey
          ::
          %del-q
          =/  hollow  +:(del:q-orm:fl questions.this-survey +.data)
          =+  q-below=+(+.data)
          =/  new-questions=questions
          ?<  |((gth +.data q-count.this-survey) =(0 +.data))
          %^    move-q-up-after-delete:fl
              hollow 
            q-below 
          q-count.this-survey
          =.  questions.this-survey
            new-questions
          =.  q-count.this-survey
            (dec q-count.this-survey)
          this-survey
          ::
          %move-q
          ?<
          ?|    (gth old.data q-count.this-survey)
              (gth new.data q-count.this-survey)
            =(0 old.data)  =(0 new.data)
          ==
          =/  current=question
            (need (get:q-orm:fl questions.this-survey old.data))
          ?:  (gth old.data new.data)  ::  'move up'
            =/  new-questions=questions
            (move-qs-down:fl current questions.this-survey old.data new.data)
            =.  questions.this-survey
              new-questions
            this-survey
          ?>  (gth new.data old.data)  ::  'move down'
          =/  new-questions=questions
          (move-qs-up:fl current questions.this-survey old.data new.data)
          =.  questions.this-survey
            new-questions
          this-survey
          ::
            %edit-q
          ?<  (gth question-id.data q-count.this-survey)
          =/  this-question=question
            (need (get:q-orm:fl questions.this-survey question-id.data))
          =.  q-title.this-question
            q-title.data
          =.  front.this-question
            front.data
          =.  back.this-question
            back.data
          =.  required.this-question
            required.data
          =.  options.this-question
            options.data
          =.  questions.this-survey
            %^    put:q-orm:fl
                questions.this-survey 
              question-id.data 
            this-question
          this-survey
        ==
        =+  this-survey=`survey`(got:s-orm:fl new-surveys survey-id.act)
        ?:  =(%private visibility.this-survey)
          =/  subs
            ~(tap in (need (~(get by subscribers) survey-id.act)))
          :_ 
          %=  state
              surveys      new-surveys
              subscribers  (~(put by subscribers) survey-id.act *ships)
          ==
          %+  turn
            subs
          |=(a=@p [%give %kick ~[/survey/(scot %ud survey-id.act)] `a])
        :_
        ?.  =(+14.act %slug)
          %=  state
              surveys  new-surveys
          ==
        =/  del-slugs  ^+  slugs
          (~(del by slugs) untouched-slug)
        =/  new-slugs  ^+  slugs
          (~(put by del-slugs) slug.this-survey survey-id.act)
        %=  state
            surveys  new-surveys
            slugs    new-slugs
        ==
        :~  :*
          %give  %fact   ~[/survey/(scot %ud survey-id.act)]
          %forms-update
          !>  
          ^-  update
          survey+`survey`this-survey
        ==  ==
      ::
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
  ==
++  on-leave  on-leave:def
++  on-peek   on-peek:def
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
      =+  new-defunct=(put:s-orm:fl defunct id survey)
      =+  new-surveys=+:(del:s-orm:fl surveys id)
      `this(surveys new-surveys, defunct new-defunct)
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
          =/  del-defunct  ^+  surveys
            +:(del:s-orm:fl defunct id)
          `this(surveys new-surveys, defunct del-defunct)
          ::
        ==
      ==
    ==
  ==
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
