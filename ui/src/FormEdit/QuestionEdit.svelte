<script>

  import { edits } from '../Themes/Default/config'
  import { active } from '../UrbitStore'
  import { page } from '$app/stores'
  import QuestionHeader from './QuestionHeader.svelte'
  import QuestionFooter from './QuestionFooter.svelte'
  import Statements from './Statements.svelte'

  export let n

</script>
<div class="container">
  {#if $active[1][n].sec.length > 0}
    {#each $active[1][n].sec as a, i}
      <div class="qbox">
        {#each edits as b}
          {#if b.display === a.display}
            <QuestionHeader {n} {i} />
            <Statements {n} {i} />
            <svelte:component this={b.component} {i} {n} />
            <QuestionFooter {n} {i}/>
          {/if}
        {/each}
      </div>
    {/each}
  {/if}
</div>

<style>

  .qbox {
    margin-top: 2em;
    padding: 1em 2em 2em 2em;
    border-radius: 8px;
    background: white;
    box-shadow: 0 0 8px 2px #d1d1d1;
  }

  .container {
    margin-bottom: 2em;
  }

</style>
