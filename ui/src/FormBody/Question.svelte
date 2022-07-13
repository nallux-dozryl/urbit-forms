<script>

  import { statements, inputs } from '../Themes/Default/config'
  import { active } from '../UrbitStore'

  export let i, n, nsec

  function makeAnsQuestion() {
      $active[2][n].sec.push({
        a: [],
        b: [],
        c: []
      })
      active.set($active)
  }

</script>
<div class="container">
  <div class="qid">{i + 1}</div>
  {#if $active[2][n].sec[i] === undefined}
    {makeAnsQuestion()}
  {/if}
  {#each $active[1][n].sec[i].statements as a, i}
    {#each statements as b}
      {#if b.display === a.display}
        <svelte:component
          this={b.component}
          x={a.x} 
          y={a.y}
          z={a.z}
        />
      {/if}
    {/each}
  {/each}
  {#each inputs as c}
    {#if $active[1][n].sec[i].display === c.display}
      {#if $active[1][n].sec[i].required}
        <div class="req">Required</div>
      {/if}
      <svelte:component this={c.component} {n} {i} />
    {/if}
  {/each}
</div>

<style>

  .req {
    font-size: .7em;
    color: #666;
    margin: 0 0 .6em 1em;
    font-weight: 600;
  }


  .section-number {
    text-align: center;
    font-size: 1.2em;
    font-weight: 500;
    margin-bottom: 1em;
  }

  .qid {
    font-size: 2em;
    font-weight: 500;
    padding-bottom: .3em;
  }

  .container {
    border-bottom: solid 1px #e9e9e9;
    margin-bottom: 2em;
  }

</style>
