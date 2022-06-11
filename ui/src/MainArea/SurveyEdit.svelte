<script>
  // Main Area
  import NewQuestion from './NewQuestion.svelte'
  import QContainer from '../Edit/QContainer.svelte'

  // Defining things
  export let survey;

</script>

<div class="container">
  {JSON.stringify(survey[1])}
  {#each survey[1] as qs}
    <QContainer qs={qs}/>
  {/each}
  <NewQuestion sid={survey[0].id}/>
</div>

<style>

  .container {
    width: 80%;
    margin: auto;
  }

</style>
