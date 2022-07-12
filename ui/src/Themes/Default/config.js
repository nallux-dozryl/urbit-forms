
  import TitleView from './Statements/TitleView.svelte'
  import EssayView from './Statements/EssayView.svelte'

  import TextInput from './Inputs/TextInput.svelte'
  import OneInput from './Inputs/OneInput.svelte'
  import RangeInput from './Inputs/RangeInput.svelte'
  import ManyInput from './Inputs/ManyInput.svelte'
  import CalInput from './Inputs/CalInput.svelte'

  import TitleViewEdit from './Edits/TitleViewEdit.svelte'
  import EssayViewEdit from './Edits/EssayViewEdit.svelte'
  import TextInputEdit from './Edits/TextInputEdit.svelte'
  import RangeInputEdit from './Edits/RangeInputEdit.svelte'
  import OneInputEdit from './Edits/OneInputEdit.svelte'
  import ManyInputEdit from './Edits/ManyInputEdit.svelte'
  import CalInputEdit from './Edits/CalInputEdit.svelte'
 
  export const statements = [
    { display: 'title-view', component: TitleView },
    { display: 'essay-view', component: EssayView },
  ]

  export const inputs = [
    { display: "text-input", component: TextInput   },
    { display: "range-input", component: RangeInput },
    { display: "one-input",   component: OneInput   },
    { display: "many-input",  component: ManyInput  },
    { display: "cal-input",   component: CalInput   },
  ]
  
  export const edits = [
    { display: 'title-view', component: TitleViewEdit   },
    { display: 'essay-view', component: EssayViewEdit   },
    { display: "text-input", component: TextInputEdit   },
    { display: "range-input", component: RangeInputEdit },
    { display: "one-input",   component: OneInputEdit   },
    { display: "many-input",  component: ManyInputEdit  },
    { display: "cal-input",   component: CalInputEdit   },
  ]
