<script>

  import NotAnswered from './NotAnswered.svelte'
  import { afterUpdate } from 'svelte'

  export let info, q

  let calendar = [
    {month: "January", days:31},  
    {month: "February", days:28}, 
    {month: "March", days:31}, 
    {month: "April", days:30}, 
    {month: "May", days:31},  
    {month: "June", days:30}, 
    {month: "July", days:31}, 
    {month: "August", days:31}, 
    {month: "September", days:30},  
    {month: "October", days:31}, 
    {month: "November", days:30}, 
    {month: "December", days:31}, 
  ]


</script>

{#if (info.a[0] === undefined) && (info.b[0] === undefined)}
  <NotAnswered />
{:else}
<div class="answer">
  {#each info.b as c}
    {#if (q.x[0] === "date") || (q.x[0] === "datetime")}
      {#if c.x === "year"}
        <div class="year">{c.y}</div>
      {:else if c.x === "month"}
        <div class="month">{calendar[c.y - 1].month}</div>
      {:else if c.x === "day"}
          {c.y}
        {#if (q.x[0] === "datetime")},{/if}
      {/if}
    {/if}
    {#if (q.x[0] === "time") || (q.x[0] === "datetime")}
      {#if c.x === "hour"}
        <div class="hour">{c.y}:</div>
      {:else if c.x === "minute"}
        {c.y}
      {:else if c.x === "meridiem"}
        {c.y}
      {/if}
    {/if}
  {/each}
</div>
{/if}
<style>

  .answer {
    margin-top: 1em;
    font-size: 1em;
    font-weight: 200;
    color: #666;
    display: flex;
  }

  .year {
    padding-left: 1em;
    padding-right: .3em;
  }

  .month {
    padding-right: .3em;
  }

  .hour {
    padding-left: 1em;
  }

  .split {
    width: .5em;
    font-size: 2em;
  }

  input[type="number"] {
    border: none;
    text-align: center;
    background: #e9e9e9;
    border-radius: 4px;
    font-size: 2em;
  }

  input:focus {
    outline: none;
  }

  button {
    background: white;
    border: solid 1px #e9e9e9;
    border-radius: 4px;
    padding: 1.6em;
  }

  button:hover {
    color: white;
    background: grey;
    border-color: grey;
  }

  .selected {
    margin: auto;
    background: #e9e9e9;
    border-radius: 4px;
    width: 14em;
    text-align: center;
    padding: 1em;
    margin-bottom: 2em;
  }

</style>
