<script>
  import { active, editResLimit } from '../../UrbitStore'

</script>

<div class="section">
  <div class="title">Response Limit</div>
  <div class="arg">
    <input
      type="number"
      bind:value={$active[0].rlimit}
      on:blur={
        editResLimit({
          id: $active[0].id, 
          rlimit: $active[0].rlimit})}
    />
    {$active[0].rlimit === 0 ? "unlimited" : ""}
  </div>
</div>

<style>

  .section {
    margin: 2em 0 2em .6em;
  }

  .title {
    font-size: 1.2em;
    font-weight: 500;
  }

  .arg {
    margin-top: 1em;
    font-size: .8em;
  }

  input {
    border: none;
    background: #e9e9e9;
    padding: 1em;
    border-radius: 4px;
    margin-left: .4em;
    color: #505050;
  }

  input:focus {
    outline: none;
  }

</style>
