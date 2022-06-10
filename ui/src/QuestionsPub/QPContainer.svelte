<script>
  import Short from './Short.svelte'
//  import Long from './Long.svelte'
//  import One from './One.svelte'
//  import Many from './Many.svelte'
//  import LinearDisc from './LinearDisc.svelte'
//  import LinearCont from './LinearCont.svelte'

    export let qs
    export let sid

</script>

<div class="container">
  <div class="num">
    Question {qs.qid} 
  </div>
  <div class="text">
    {qs.qtitle}
  </div>
  {#if qs.front === "short"}
    <Short qid={qs.qid} sid={sid}/>
  {/if}
</div>

<style>

  .container {
    min-height: 6em;
    margin: auto;
    max-width: 80%;
    border-bottom: 1px solid black;
  }

  .num {
    margin: auto;
    text-align: center;
    border-bottom: 1px solid black;
  }

  .text {
    flex: 19;
    margin: 2em 0 2em 0;
  }

</style>
