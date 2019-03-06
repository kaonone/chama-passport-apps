import React from 'react'
import {
  AragonApp,
  Button,
  Text,

  observe
} from '@aragon/ui'
import Aragon, { providers } from '@aragon/client'
import styled from 'styled-components'

const AppContainer = styled(AragonApp)`
  display: flex;
  align-items: center;
  justify-content: center;
`

export default class App extends React.Component {
  render () {
    return (
      <AppContainer>
        <div>
          {/* <ObservedCount observable={this.props.observable} /> */}
          <ObservedIdentity observable={this.props.observable} />
          <Button onClick={() => this.props.app.register(42, "Foo", "Boo")}>Registration</Button>
        </div>
      </AppContainer>
    )
  }
}

// const ObservedCount = observe(
//   (state$) => state$,
//   { count: 0 }
// )(
//   ({ count }) => <Text.Block style={{ textAlign: 'center' }} size='xxlarge'>{count}</Text.Block>
// )

const ObservedIdentity = observe(
  (state$) => state$,
  { count: 0, identity: 0 }
)(
  ({ count, identity }) => {
    return [
      <Text.Block style={{ textAlign: 'center' }} size='xxlarge'>{count}</Text.Block>,
      <Text.Block style={{ textAlign: 'center' }} size='xxlarge'>{identity}</Text.Block>
    ];
  }
)
