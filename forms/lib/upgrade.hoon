/-  *forms-states,  zero=forms-0,  one=forms
|%
::
++  convert-0-to-1
  |=  [old=state-0 our=ship]
  |^ 
  ^-  state-1
  :*
    %1
    (metas-to-header metas.old)
    (content-to-stuffing content.old)
    (~(put by *slug-store) our slugs.old)
    pending.old
    subscribers.old
    (results-to-submissions results.old) 
  ==
  ::
  ++  sections-orm  ((on section-id:one section:one) lth)
  ::
  ++  metas-to-header
    |=  input=metas:zero
    ^-  header:one
    (~(urn by input) make-metadata-1)
  ::
  ++  make-metadata-1
    |=  [k=survey-id:one v=metadata:zero]
    ^-  metadata-1:one
    :*
      author.v
      status.v
      slug.v
      title.v
      description.v
      visibility.v
      spawn.v
      updated.v
      rlimit.v
      [~[q-count.v] 1]
    ==
  ++  results-to-submissions
    |=  input=results:zero
    ^-  submissions:one
    (~(urn by input) make-responses-1)
  ::
  ++  make-responses-1
    |=  [k=survey-id:one v=responses:zero]
      ^-  responses-1:one
    (~(urn by v) make-response-1)
  ::
  ++  make-response-1
    |=  [k=response-id:one s=author:one a=answers:zero]
    ^-  response-1:one
    :-  s
    (put:sections-orm *sections:one 1 (~(urn by a) make-answer-section))
  ::
  ++  make-answer-section
    |=  [k=question-id:one a=answer:zero]
    ^-  answer-1:one
    :*
      %answer
      -.a
      ?-  -.a
        %grid  [~ +.a ~]
        %text  [~[+.a] ~ ~]
        %list  [+.a ~ ~]
      ==
    ==
  ++  content-to-stuffing
    |=  input=content:zero
    ^-  stuffing:one
    (~(urn by input) make-sections)
  ::
  ++  make-sections
    |=  [k=survey-id:one v=questions:zero]
    ^-  sections:one
    (put:sections-orm *sections:one 1 (make-questions v))
  ::
  ++  make-questions
    |=  =questions:zero
    ^-  section:one
    (~(urn by questions) make-q)
  ::
  ++  make-q
    |=  [k=question-id:one v=question:zero]
    ^-  question-1:one
    :-  %question
    ?-  front.v
        %statement
      :*
        'none'  'none'
        |  0  0
        ~  ~  ~
        ^-  (list statement:one)
        ~[[~[qtitle.v] ~ ~ 'essay-view']]
      ==
        %short
      ['short-input' 'text' required.v 0 0 ~ ~ ~ (make-statements v)]
        %long
      ['essay-input' 'text' required.v 0 0 ~ ~ ~ (make-statements v)]
        %one
      ['one-input' 'text' required.v 0 0 x.v ~ ~ (make-statements v)]
        %grid-one
      ['one-input' 'list' required.v 0 0 x.v y.v ~ (make-statements v)]
        %many
      ['many-input' 'list' required.v 0 0 x.v ~ ~ (make-statements v)]
        %grid-many
      ['many-input' 'grid' required.v 0 0 x.v y.v ~ (make-statements v)]
        %linear-discrete
      :*
        'range-input'
        'text'
        required.v
        (slav %ud (snag 0 x.v))
        (slav %ud (snag 0 y.v))
        ~['linear']
        ~
        ~
        (make-statements v)
      ==
        %linear-continuous
      :*
        'range-input'
        'text'
        required.v
        (slav %ud (snag 0 x.v))
        (slav %ud (snag 0 y.v))
        ~['continuous']
        ~
        ~
        (make-statements v)
      ==
        %calendar
      :*
        'cal-input'
        'datetime'
        required.v
        0
        0
        ~['datetime']
        ~
        ~
        (make-statements v)
      ==
    ==
  ::
  ++  make-statements
    |=  q=question:zero
    ^-  (list statement:one)
    ~[[~[qtitle.q] ~ ~ 'title-view']]
  ::
  ++  make-statements-essay
    |=  q=question:zero
    ^-  (list statement:one)
    ~[[~[qtitle.q] ~ ~ 'essay-view']]
  --
--
