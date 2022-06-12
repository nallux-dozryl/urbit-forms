<script>
  import { active } from '../UrbitStore'
  import Short from './Questions/Short.svelte'

  export let qs

    let data;
    active.subscribe(res => data = res)

</script>

<div class="container">
  <div class=num>
    Question {qs.qid}
    {#if qs.required}
      <span>*</span>
    {/if}
  </div>
  <div class="qtitle">
    {qs.qtitle}
  </div>
  {#if qs.front === "short"}
    <Short q={qs} sid={data[0].id}/>
  {/if}
</div>

<style>

  span {
    color: red;
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
