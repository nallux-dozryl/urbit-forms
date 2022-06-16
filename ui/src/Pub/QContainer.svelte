<script>
  import { active } from '../UrbitStore'
  import Short from './Questions/Short.svelte'
  import Long from './Questions/Long.svelte'
  import One from './Questions/One.svelte'
  import Many from './Questions/Many.svelte'
  import LinearDisc from './Questions/LinearDisc.svelte'
  import LinearCont from './Questions/LinearCont.svelte'
  import GridOne from './Questions/GridOne.svelte'

  export let qs

    let data;
    active.subscribe(res => data = res)

    let spqs = qs.qtitle.split(/\r?\n/)

</script>

<div class="container">
  <div class=num>
    Question {qs.qid}
    {#if qs.required}
      <span>*</span>
    {/if}
  </div>
  <div class="qtitle">
    {#each spqs as qsln}
      {#if qsln}
        <p class="line">{qsln}</p>
      {:else}
        <br />
      {/if}
    {/each}
  </div>
  {#if qs.front === "short"}
    <Short q={qs} sid={data[0].id} />
  {:else if qs.front === "long" }
    <Long q={qs} sid={data[0].id} />
  {:else if qs.front === "one"}
    <One q={qs} sid={data[0].id} />
  {:else if qs.front === "many"}
    <Many q={qs} sid={data[0].id} />
  {:else if qs.front === "linear-discrete"}
    <LinearDisc q={qs} sid={data[0].id} />
  {:else if qs.front === "linear-continuous"}
    <LinearCont q={qs} sid={data[0].id} />
  {:else if qs.front === "grid-one"}
    <GridOne q={qs} sid={data[0].id} />
  {/if}
</div>

<style>

  span {
    color: red;
  }

  .line {
    margin: 0;
  }

  .qtitle {
    padding: 1em; 
  }

  .container {
    margin: auto;
    max-width: 80%;
    border-bottom: 1px solid black;
  }

  .num {
    margin: auto;
    text-align: center;
    border-bottom: 1px solid black;
    padding: 4px;
  }

</style>
