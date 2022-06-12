/-  *forms
/+  default-agent, dbug, fl=forms
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
    =metas
    =content
    =slugs
    =pending
    =subscribers
    =results
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
      =/  this-metadata=metadata
        (create-metas:fl act our.bowl now.bowl)
      =/  new-slugs
        ^+  slugs
        (~(put by slugs) slug.act id)
      =/  new-metas  
        ^+  metas
        (put:m-orm:fl metas id this-metadata)
      :-  ~
      %=  state
        content      (put:c-orm:fl content id *questions)
        metas        (put:m-orm:fl metas id this-metadata)
        slugs        (~(put by slugs) slug.act id)
        subscribers  (~(put in subscribers) id *ships)
        results      ^+  results
        =/  n=responses
          (put:re-orm:fl *responses %draft [our.bowl *answers])
        (put:r-orm:fl results id n)
      ==
      ::
        %medit
      =+  this-metadata=(got:m-orm:fl metas survey-id.act)
      =.  updated.this-metadata
        now.bowl
      =.  title.this-metadata
        title.act
      =.  description.this-metadata
        description.act
      =+  dead-slugs=(~(del by slugs) slug.this-metadata)
      =.  slug.this-metadata
        slug.act
      =+  new-slugs=(~(put by dead-slugs) slug.act survey-id.act)
      =.  visibility.this-metadata
        visibility.act
      =.  rlimit.this-metadata
        rlimit.act
      =/  this-u-questions=(unit questions)
        (get:c-orm:fl content survey-id.act)
      =/  this-questions=questions
        ?~  this-u-questions
          ~
        (need this-u-questions)
      ?.  =(%private visibility.this-metadata)
        :_  
        %=  state
          metas  (put:m-orm:fl metas survey-id.act this-metadata)
          slugs  new-slugs
        ==
        :~  :*
          %give  %fact  [/survey/(scot %ud survey-id.act) ~]
          %forms-update  !>  `update`metadata+this-metadata
        ==  ==
      =/  subs
        ~(tap in (~(got by subscribers) survey-id.act))
      :_  
      %=  state
        metas        (put:m-orm:fl metas survey-id.act this-metadata)
        slugs        new-slugs
        subscribers  (~(del by subscribers) survey-id.act)
      ==
      ?:  =(0 (lent subs))
        ~
      %+  turn
        subs
      |=(a=@p [%give %kick ~[/survey/(scot %ud survey-id.act)] `a])
        ::
        %ask
      :_  state(pending (~(put in pending) [author.act slug.act]))
      :~  :*
        %pass   /slug
        %agent  [author.act %forms]
        %poke   %forms-request  !>  slug+slug.act
      ==  ==
        ::
        %submit
      =+  rid=123.123.123
      =+  draft=*answers
      =+  anz=(put:a-orm:fl draft 1 [%text 'doing good'])
      =+  anztwo=(put:a-orm:fl anz 2 [%text 'didnt have to answer this btw'])
      =+  anzthree=(put:a-orm:fl anz 3 [%text 'bot'])
      =+  res=[108.453.367.988.368.748 rid anzthree]
      :_  state
      :~  :*
        %pass   /submit
        %agent  [author.act %forms]
        %poke   %forms-request  !>  response+res
      ==  ==
        ::
        %qnew
      =+  this-metadata=`metadata`(need (get:m-orm:fl metas survey-id.act))
      ?>  =(our.bowl author.this-metadata)
      =+  this-questions=`questions`(need (get:c-orm:fl content survey-id.act))
      =+  inc=+(q-count.this-metadata)
      =+  new-questions=`questions`(put:q-orm:fl this-questions inc +7:act)
      =.  q-count.this-metadata
        `q-count`inc
      =.  updated.this-metadata
        now.bowl
      :_  %=  state 
            content  (put:c-orm:fl content survey-id.act new-questions)
            metas    (put:m-orm:fl metas survey-id.act this-metadata)
          ==
      :~  :*
        %give  %fact  [/survey/(scot %ud survey-id.act) ~]
        %forms-update  !>  `update`questions+this-questions
      ==  ==
        ::
        %qedit
      =+  this-metadata=(need (get:m-orm:fl metas survey-id.act))
      ?>  =(our.bowl author.this-metadata)
      ?>  (lte question-id.act q-count.this-metadata)
      =+  qs=(need (get:c-orm:fl content survey-id.act))
      =+  new-qs=(put:q-orm:fl qs question-id.act question.act)
      :_  %=  state
            content  (put:c-orm:fl content survey-id.act new-qs)
          ==
      :~  :*
        %give  %fact  [/survey/(scot %ud survey-id.act) ~]
        %forms-update  !>  `update`questions+new-qs
      ==  ==
        ::
        %qdel
      =+  this-metadata=(need (get:m-orm:fl metas survey-id.act))
      ?>  =(our.bowl author.this-metadata)
      ?>  (lte question-id.act q-count.this-metadata)
      =+  this-questions=(need (get:c-orm:fl content survey-id.act))
      =+  hollow=+:(del:q-orm:fl this-questions question-id.act)
      =/  new-questions=questions
      %^    move-q-up-after-delete:fl 
          hollow 
        +(question-id.act) 
      q-count.this-metadata
      =.  q-count.this-metadata
        (dec q-count.this-metadata)
      =.  updated.this-metadata
        now.bowl
      :_  %=  state
            content  (put:c-orm:fl content survey-id.act new-questions)
            metas    (put:m-orm:fl metas survey-id.act this-metadata)
          ==
      :~  :*
        %give  %fact  [/survey/(scot %ud survey-id.act) ~]
        %forms-update  !>  `update`survey+[this-metadata new-questions]
      ==  ==
        ::
        %dedit
      =+  this-ress=(got:r-orm:fl results survey-id.act)
      =+  resp=(got:re-orm:fl this-ress %draft)
      =+  this-ans=(put:a-orm:fl answers.resp question-id.act answer.act)
      =+  new-ress=(put:re-orm:fl this-ress %draft [author.resp this-ans])
      :-  ~  
      %=  state
        results  ^+  results
        (put:r-orm:fl results survey-id.act new-ress)
      ==  
        ::
        %delete
      =+  this-metadata=(got:m-orm:fl metas survey-id.act)
      =+  new-metas=+:(del:m-orm:fl metas survey-id.act)
      =+  new-content=+:(del:c-orm:fl content survey-id.act)
      =+  new-slugs=(~(del by slugs) slug.this-metadata)
      ?.  =(our.bowl author.this-metadata)
        :_  %=  state
              metas    new-metas
              content  new-content
              slugs    new-slugs
            ==        
        :~  :*
          %pass
          /updates/(scot %ud survey-id.act)
          %agent
          [author.this-metadata %forms]
          %leave  ~
        ==  ==
      =/  subs
        ~(tap in (~(got by subscribers) survey-id.act))
      :_  %=  state
            metas        new-metas
            content      new-content
            slugs        new-slugs
            subscribers  (~(del by subscribers) survey-id.act)
          ==
      ?:  =(0 (lent subs))
        ~
      %+  turn
        subs
      |=(a=@p [%give %kick ~[/survey/(scot %ud survey-id.act)] `a])
    ==
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
        %response
        ~|  'invalid response'
        =+  this-metas=(need (get:m-orm:fl metas survey-id.req))
        ?>  =(our.bowl author.this-metas)
        =/  qs=questions  (need (get:c-orm:fl content survey-id.req))
        ?>  (check-answer-format:fl q-count.this-metas qs answers.req)
        ~&  >>  'checks out'
        `state
    ==
  --  
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+  path  (on-watch:def path)
      [%survey @ ~]
    =/  id=survey-id   (slav %ud i.t.path)
    =+  this-metadata=(need (get:m-orm:fl metas id))
    ?>  =(%public visibility.this-metadata)
    =+  x=(get:c-orm:fl content id)
    =/  this-questions=questions
    ?~  x
      *questions
    (need x)
    :_  this(subscribers (add-subs:fl subscribers id src.bowl))
    :~  :*
      %give  %fact   ~
      %forms-update  !>  `update`init+[this-metadata this-questions]
    ==  ==
  ==
++  on-leave  on-leave:def
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  (on-peek:def path)
      [%x %metas ~]
    :^  ~  ~  %forms-json
    !>  ^-  frontend
    metas+metas
    ::
      [%x %active @ ~]
    :^  ~  ~  %forms-json
    !>  ^-  frontend
    =+  id=`survey-id`(slav %ud i.t.t.path)
    :-  %active
    :+  id
    ^-  survey  
    :-  metadata=`metadata`(need (get:m-orm:fl metas id))
    questions=`questions`(need (get:c-orm:fl content id))
    ^-  answers
    answers:(got:re-orm:fl (got:r-orm:fl results id) %draft)
  ==
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+  wire  (on-agent:def wire sign)
    [%slug ~]
    ?.  ?=(%poke-ack -.sign)  (on-agent:def wire sign)
    ?~  p.sign
      `this
    ::
      %-  %-  slog  ^-  tang  (need p.sign)  `this
    [%submit ~]
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
      =+  this-metadata=(need (get:m-orm:fl metas id))
      =.  status.this-metadata  %archived
      =+  new-metas=(put:m-orm:fl metas id this-metadata)
      `this(metas new-metas)
      ::
      %fact
      ~&  >>>  'fax'
      ?+  p.cage.sign  (on-agent:def wire sign)
        %forms-update
        =/  id=survey-id  (slav %ud i.t.wire)
        =+  upd=!<(update q.cage.sign)
        ?-  -.upd
            %metadata
          :-  ~
          %=  this
            metas  ^+  metas
            (put:m-orm:fl metas id metadata.upd)
          ==
          ::
           %questions
          :-  ~
          %=  this
            content  ^+  content
            (put:c-orm:fl content id questions.upd)
          ==
          ::
           %survey
          :-  ~
          %=  this
            metas  
              ^+  metas
            (put:m-orm:fl metas id metadata.upd)
            content
              ^+  content
            (put:c-orm:fl content id questions.upd)
          ==
          ::
            %init
          =+  this-responses=(get:r-orm:fl results id)
          :-  ~
          %=  this
            metas  ^+  metas
            (put:m-orm:fl metas id metadata.upd)
            content  ^+  content
            (put:c-orm:fl content id questions.upd)
            results  ^+  results
            ?~  this-responses
              =/  n=responses
              (put:re-orm:fl *responses %draft [our.bowl *answers])
              (put:r-orm:fl results id n)
            =/  m=responses
            (put:re-orm:fl (need this-responses) %draft [our.bowl *answers])
            (put:r-orm:fl results id m)
          ==

        ==
      ==
    ==
  ==
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
