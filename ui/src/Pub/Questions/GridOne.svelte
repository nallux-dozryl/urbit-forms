<script>
  import { editDraft } from '../../UrbitStore'

  export let q;
  export let sid;

  let coord = q.answer;

  function handleUpdate(ox) {
    const data = {
      surveyid: sid,
      questionid: q.qid,
      ans: {grid: coord}
    }
    console.log(coord)
    editDraft(data) 
  }
</script>
<div class="container">
  <div class="row-names">
  {#if q.y}
    <br class="row" />
    {#each q.y as oy, i}
      <div class="row">{oy}</div>
    {/each}
  {/if}
  </div>
  {#if q.x}
    {#each q.x as ox}
      <div class="column-row">
        {#if q.y}
          <div class="row">{ox}</div>
          {#each q.y as oy, i}
            <div class="row">
              {#if coord[i]}
                {#if (coord[i].y === oy) && (coord[i].x === ox)}
                  <input type="radio" checked on:blur={handleUpdate} />
                {:else}
                  <input 
                    type="radio"
                    bind:group={coord[i]}
                    value={{x:ox,y:oy}}
                    on:blur={handleUpdate}
                  /> 
                {/if}
              {:else}
                  <input 
                    type="radio"
                    bind:group={coord[i]}
                    value={{x:ox,y:oy}}
                    on:blur={handleUpdate}
                  /> 
              {/if}
            </div>
          {/each}
        {/if}
      </div>
    {/each}
  {/if}
</div>

<style>

  .container {
    display: flex;
  }

  .row-names {
    display: flex;
    flex: 1;
    flex-direction: column;
  }

  .row {
    text-align: right;
    flex: 1;
  }

  .column-row {
    flex: 1;
    text-align: center;
  }

</style>
