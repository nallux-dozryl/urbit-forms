/-  forms
/+  default-agent, dbug, urforms
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 =metadata:forms =tower:forms =questions:forms]
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this   .
    def    ~(. (default-agent this %.n) bowl)
    tsnap  tsnap:urforms
    qdel   qdel:urforms
    wdel   wdel:urforms
::
++  on-init
  ^-  (quip card _this)
  =+  end=~9999.12.31
  :-  ~  %=  this
    tower  ~[[0w0 ~]]
  metadata  ~[[0w0 'orphanage' *@da now.bowl end end | %draft]]
  ==
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
::++  on-poke  on-poke:def
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?>  =(src.bowl our.bowl)
  ?+  mark  (on-poke:def mark vase)
    %form-builder
      =/  action  !<(faction:forms vase)
      ?-  -.action
        %form-add
          =+  id=`@uw`(shaf name:action now.bowl)
          =+  form=`wall:forms`[id ~]
          =/  meta
          ^-  meta:forms
            :*  id             name:action
                now.bowl       now.bowl
                start:action   end:action
                public:action  %draft
            ==
          :-  ~  %=  this
            tower     (weld tower ~[form])
            metadata  (weld metadata ~[meta])
          ==
         ::`this
      ==
    ::
    %question-builder
      =/  action  !<(qaction:forms vase)
      ?-  -.action
        %question-add
          =+  id=id:action
          =+  qid=`(list qid:forms)`[`@uw`(shaf id now.bowl) ~]
          =+  :+  idx=0  len=(lent tower)
                cement=`cement:forms`[-:qid now.bowl brick:action]
          |-  ?>    (lth idx len)
          =+  wall=(snag idx tower)
          ?.  =(id -:wall)  $(idx +(idx))
          ::=+  perm=(snag idx permissions)
          =+  qids=`(list qid:forms)`+:wall
          :-  ~  %=  this
            tower      (tsnap idx tower [id (weld qids qid)])
            questions  (weld questions ~[cement])
          ==
        ::
        %question-del
          =+  [id=id:action qid=qid:action idx=0 len=(lent tower)]
          |-  ?>  (lth idx len)
          =+  wall=(snag idx tower)
          ?.  =(id -:wall)  $(idx +(idx))
          =+  [qidx=0 qlen=(lent +:wall)]
          |-  ?>  (lth qidx qlen)
          =+  qidl=(snag qidx +:wall)
          ?.  =(qid qidl)  $(qidx +(qidx))
          :-  ~  %=  this
            questions  (qdel qidx questions)
            tower      (tsnap idx tower (wdel qidx id +:wall))
          ==
        ::
      ==
  ==  
::
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
