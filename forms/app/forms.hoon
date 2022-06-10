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
      ==
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
      =+  this-questions=`questions`(need (get:c-orm:fl content survey-id.act))
      =+  inc=+(q-count.this-metadata)
      =+  new-questions=`questions`(put:q-orm:fl this-questions inc +7:act)
      =.  q-count.this-metadata
        `q-count`inc
      :-  ~
      %=  state 
        content  (put:c-orm:fl content survey-id.act new-questions)
        metas    (put:m-orm:fl metas survey-id.act this-metadata)
      ==
        %qedit
      =+  count=q-count:(need (get:m-orm:fl metas survey-id.act))
      ?>  (lte question-id.act count)
      =+  qs=(need (get:c-orm:fl content survey-id.act))
      =+  new-qs=(put:q-orm:fl qs question-id.act question.act)
      :-  ~
      %=  state
        content  (put:c-orm:fl content survey-id.act new-qs)
      ==
        %qdel
      =+  this-metas=(need (get:m-orm:fl metas survey-id.act))
      ?>  (lte question-id.act q-count.this-metas)
      =+  this-questions=(need (get:c-orm:fl content survey-id.act))
      =+  hollow=+:(del:q-orm:fl this-questions question-id.act)
      =/  new-questions=questions
      %^    move-q-up-after-delete:fl 
          hollow 
        +(question-id.act) 
      q-count.this-metas
      =.  q-count.this-metas
        (dec q-count.this-metas)
      :-  ~ 
      %=  state
        content  (put:c-orm:fl content survey-id.act new-questions)
        metas    (put:m-orm:fl metas survey-id.act this-metas)
      ==
        %dedit
      ~&  >>  act
      `state
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
    ~&  >>  x
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
      [%x %survey @ ~]
    :^  ~  ~  %forms-json
    !>  ^-  frontend
    =+  id=`survey-id`(slav %ud i.t.t.path)
    :-  %survey
    :-  id
    ^-  survey  
    :-  metadata=`metadata`(need (get:m-orm:fl metas id))
    questions=`questions`(need (get:c-orm:fl content id))
    ::
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
            %survey
          :-  ~
          %=  this
            metas  
              ^+  metas
            (put:m-orm:fl metas id metadata.upd)
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
