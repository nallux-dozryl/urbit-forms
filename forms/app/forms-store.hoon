/-  forms
/+  default-agent, dbug
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 =shelf:forms =sections:forms]
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this   .
    def    ~(. (default-agent this %.n) bowl)
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
  ?>  =(src.bowl our.bowl)  
  ?+  mark  (on-poke:def mark vase)
    %booklet
      =/  action  !<(booklet-action:forms vase)
      ?-  -.action
        %create
        =+  id=(shaf title.action now.bowl)
        =/  booklet  ^-  booklet:forms
          [[title.action desc.action now.bowl vis.action ~[our.bowl]] ~]
        `this(shelf `shelf:forms`(~(put by shelf) id booklet))
        %delete
        =+  [sel=(~(got by shelf) id.action) n=0 del=*(list [sid:forms section:forms])]
        |-  ?:  (lth n (lent contents.booklet.sel))
        $(n +(n), del [[(snag n contents.booklet.sel) *section:forms] del])
        =+  new-sections=(~(dif by sections) `sections:forms`(malt del))
        `this(shelf (~(del by shelf) id.action), sections new-sections)
      ==
    ::
    %metadata
      =/  action  !<(meta-action:forms vase)
      =+  sel=(~(got by shelf) id.action) 
      ?-  -.action
        %title
        =.  title.meta.booklet.sel  title.action
        `this(shelf (~(gas by shelf) ~[[id.action sel]]))
        %desc
        =.  desc.meta.booklet.sel  desc.action
        `this(shelf (~(gas by shelf) ~[[id.action sel]]))
        %vis
        =.  vis.meta.booklet.sel  vis.action
        `this(shelf (~(gas by shelf) ~[[id.action sel]]))
      ==
    ::
    %section
      =/  action  !<(section-action:forms vase)
      ?-  -.action
        %create
        =+  sid=(shaf title.action now.bowl)
        =+  sel=(~(got by shelf) id.action)
        =.  contents.booklet.sel  (flop [sid (flop contents.booklet.sel)])
        =+  section=`section:forms`[title.action desc.action ~]
        :-  ~  %=  this
          shelf     (~(gas by shelf) ~[[id.action sel]]) 
          sections  (~(put by sections) sid section)
        ==
        %delete
        =+  [n=0 sel=(~(got by shelf) id.action)]
        |-  ?.  =(sid.action (snag n contents.booklet.sel))  $(n +(n))
        =.  contents.booklet.sel
          (weld (scag n contents.booklet.sel) (slag +(n) contents.booklet.sel))
        :-  ~  %=  this
          shelf     (~(gas by shelf) ~[[id.action sel]]) 
          sections  (~(del by sections) sid.action)
        ==
        %title
        =+  sel=(~(got by sections) sid.action)
        =.  title.section.sel  title.action
        `this(sections `sections:forms`(~(gas by sections) ~[[sid.action sel]]))
        %desc
        =+  sel=(~(got by sections) sid.action)
        =.  desc.section.sel  desc.action
        `this(sections `sections:forms`(~(gas by sections) ~[[sid.action sel]]))
        %dupe
        =+  sid=(shaf sid.action now.bowl)
        =+  sel=(~(got by shelf) id.action)
        =.  contents.booklet.sel  (flop [sid (flop contents.booklet.sel)])
        :-  ~  %=  this
          sections  (~(put by sections) sid (~(got by sections) sid.action))
          shelf     (~(gas by shelf) ~[[id.action sel]])
        ==
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
